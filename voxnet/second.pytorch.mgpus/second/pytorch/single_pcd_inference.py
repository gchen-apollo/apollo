import copy
import json
import os
from pathlib import Path
import pickle
import shutil
import time
import re 
import fire
import numpy as np
import torch
from google.protobuf import text_format
import cv2

import second.data.kitti_common as kitti
import torchplus
from second.builder import target_assigner_builder, voxel_builder
from second.builder.dataset_builder import initialize_preprocess_function
from second.core import box_np_ops
from second.data.preprocess import merge_second_batch, merge_second_batch_multigpu
from second.protos import pipeline_pb2
from second.pytorch.builder import (box_coder_builder, input_reader_builder,
                                    lr_scheduler_builder, optimizer_builder,
                                    second_builder)
from second.utils.log_tool import SimpleModelLog
from second.utils.progress_bar import ProgressBar
#import psutil
from second.utils import simplevis
from second.data.pypcd import PointCloud
import pathlib

def example_convert_to_torch(example, dtype=torch.float32,
                             device=None) -> dict:
    device = device or torch.device("cuda:0")
    example_torch = {}
    float_names = [
        "voxels", "anchors", "reg_targets", "reg_weights", "bev_map", "importance"
    ]
    for k, v in example.items():
        if k in float_names:
            # slow when directly provide fp32 data with dtype=torch.half
            example_torch[k] = torch.tensor(
                v, dtype=torch.float32, device=device).to(dtype)
        elif k in ["coordinates", "labels", "num_points"]:
            example_torch[k] = torch.tensor(
                v, dtype=torch.int32, device=device)
        elif k in ["anchors_mask"]:
            example_torch[k] = torch.tensor(
                v, dtype=torch.uint8, device=device)
        elif k == "calib":
            calib = {}
            for k1, v1 in v.items():
                calib[k1] = torch.tensor(
                    v1, dtype=dtype, device=device).to(dtype)
            example_torch[k] = calib
        elif k == "num_voxels":
            example_torch[k] = torch.tensor(v)
        else:
            example_torch[k] = v
    return example_torch


def build_network(model_cfg, measure_time=False):
    voxel_generator = voxel_builder.build(model_cfg.voxel_generator)
    bv_range = voxel_generator.point_cloud_range[[0, 1, 3, 4]]
    box_coder = box_coder_builder.build(model_cfg.box_coder)
    target_assigner_cfg = model_cfg.target_assigner
    target_assigner = target_assigner_builder.build(target_assigner_cfg,
                                                    bv_range, box_coder)
    box_coder.custom_ndim = target_assigner._anchor_generators[0].custom_ndim
    net = second_builder.build(
        model_cfg, voxel_generator, target_assigner, measure_time=measure_time)
    return net


def evaluate(config_path,
             model_dir=None,
             result_path=None,
             ckpt_path=None,
             measure_time=False,
             batch_size=None,
             **kwargs):
    """Don't support pickle_result anymore. if you want to generate kitti label file,
    please use kitti_anno_to_label_file and convert_detection_to_kitti_annos
    in second.data.kitti_dataset.
    """
    assert len(kwargs) == 0
    model_dir = str(Path(model_dir).resolve())
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    result_name = 'eval_results'
    if result_path is None:
        model_dir = Path(model_dir)
        result_path = model_dir / result_name
    else:
        result_path = Path(result_path)
    if isinstance(config_path, str):
        # directly provide a config object. this usually used
        # when you want to eval with several different parameters in
        # one script.
        config = pipeline_pb2.TrainEvalPipelineConfig()
        with open(config_path, "r") as f:
            proto_str = f.read()
            text_format.Merge(proto_str, config)
    else:
        config = config_path

    input_cfg = config.eval_input_reader
    model_cfg = config.model.second
    train_cfg = config.train_config

    net = build_network(model_cfg, measure_time=measure_time).to(device)
    if train_cfg.enable_mixed_precision:
        net.half()
        print("half inference!")
        net.metrics_to_float()
        net.convert_norm_to_float(net)
    target_assigner = net.target_assigner
    voxel_generator = net.voxel_generator

    if ckpt_path is None:
        assert model_dir is not None
        torchplus.train.try_restore_latest_checkpoints(model_dir, [net])
    else:
        torchplus.train.restore(ckpt_path, net)
    batch_size = batch_size or input_cfg.batch_size
    eval_dataset = input_reader_builder.build(
        input_cfg,
        model_cfg,
        training=False,
        voxel_generator=voxel_generator,
        target_assigner=target_assigner)
    eval_dataloader = torch.utils.data.DataLoader(
        eval_dataset,
        batch_size=batch_size,
        shuffle=False,
        num_workers=input_cfg.preprocess.num_workers,
        pin_memory=False,
        collate_fn=merge_second_batch)

    if train_cfg.enable_mixed_precision:
        float_dtype = torch.float16
    else:
        float_dtype = torch.float32

    net.eval()
    result_path_step = result_path / f"step_{net.get_global_step()}"
    result_path_step.mkdir(parents=True, exist_ok=True)
    t = time.time()
    detections = []
    print("Generate output labels...")
    bar = ProgressBar()
    bar.start((len(eval_dataset) + batch_size - 1) // batch_size)
    prep_example_times = []
    prep_times = []
    t2 = time.time()

    for example in iter(eval_dataloader):
        if measure_time:
            prep_times.append(time.time() - t2)
            torch.cuda.synchronize()
            t1 = time.time()
        example = example_convert_to_torch(example, float_dtype)
        if measure_time:
            torch.cuda.synchronize()
            prep_example_times.append(time.time() - t1)
        with torch.no_grad():
            detections += net(example)
        bar.print_bar()
        if measure_time:
            t2 = time.time()

    sec_per_example = len(eval_dataset) / (time.time() - t)
    print(f'generate label finished({sec_per_example:.2f}/s). start eval:')
    if measure_time:
        print(
            f"avg example to torch time: {np.mean(prep_example_times) * 1000:.3f} ms"
        )
        print(f"avg prep time: {np.mean(prep_times) * 1000:.3f} ms")
    for name, val in net.get_avg_time_dict().items():
        print(f"avg {name} time = {val * 1000:.3f} ms")
    with open(result_path_step / "result.pkl", 'wb') as f:
        pickle.dump(detections, f)
    result_dict = eval_dataset.dataset.evaluation(detections,
                                                  str(result_path_step))
    if result_dict is not None:
        for k, v in result_dict["results"].items():
            print("Evaluation {}".format(k))
            print(v)


def _worker_init_fn(worker_id):
    time_seed = np.array(time.time(), dtype=np.int32)
    np.random.seed(time_seed + worker_id)
    print(f"WORKER {worker_id} seed:", np.random.get_state()[1][0])

def filter_param_dict(state_dict: dict, include: str=None, exclude: str=None):
    assert isinstance(state_dict, dict)
    include_re = None
    if include is not None:
        include_re = re.compile(include)
    exclude_re = None
    if exclude is not None:
        exclude_re = re.compile(exclude)
    res_dict = {}
    for k, p in state_dict.items():
        if include_re is not None:
            if include_re.match(k) is None:
                continue
        if exclude_re is not None:
            if exclude_re.match(k) is not None:
                continue
        res_dict[k] = p
    return res_dict


def visualize_results(config_path,
                     model_dir,
                     result_path):
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

    if isinstance(config_path, str):
        # directly provide a config object. this usually used
        # when you want to train with several different parameters in
        # one script.
        config = pipeline_pb2.TrainEvalPipelineConfig()
        with open(config_path, "r") as f:
            proto_str = f.read()
            text_format.Merge(proto_str, config)
    else:
        config = config_path
        proto_str = text_format.MessageToString(config, indent=2)

    input_cfg = config.train_input_reader
    eval_input_cfg = config.eval_input_reader
    model_cfg = config.model.second
    train_cfg = config.train_config
    net = build_network(model_cfg, measure_time=False).to(device)
    target_assigner = net.target_assigner
    voxel_generator = net.voxel_generator
    eval_dataset = input_reader_builder.build(
        eval_input_cfg,
        model_cfg,
        training=False,
        voxel_generator=voxel_generator,
        target_assigner=target_assigner)
    #
    # eval_dataloader = torch.utils.data.DataLoader(
    #     eval_dataset,
    #     batch_size=1,  # only support multi-gpu train
    #     shuffle=False,
    #     num_workers=eval_input_cfg.preprocess.num_workers,
    #     pin_memory=False,
    #     collate_fn=merge_second_batch)

    infos = eval_dataset.dataset.get_infos()
    result_path = Path(result_path)
    vis_result_path = result_path / 'visualization'
    vis_result_path.mkdir(parents=True, exist_ok=True)

    with open(result_path/'result.pkl', 'rb') as f:
        detections = pickle.load(f)

    classes = target_assigner.classes
    thresh = 0.3

    for i, info in enumerate(infos):
        data = eval_dataset.dataset.get_sensor_data(i)
        points = data["lidar"]["points"]
        annos = data["lidar"]["annotations"]
        gt_boxes = annos["boxes"]
        gt_names = annos["names"]
        detection = detections[i]
        dt_boxes = detection["box3d_lidar"].detach().cpu().numpy()
        dt_scores = detection["scores"].detach().cpu().numpy()
        dt_labels = detection["label_preds"].detach().cpu().numpy()
        index = dt_scores > thresh

        dt_boxes = dt_boxes[index]
        dt_labels = dt_labels[index]

        bev_map = simplevis.baidu_vis(points, gt_boxes, gt_names)

        bev_map = simplevis.draw_box_in_bev(bev_map, [-60, -60, -3, 60, 60, 1], dt_boxes, [0, 0, 255], 2)
        # cv2.imshow('gt vs dt', bev_map)
        detection_vis_file = vis_result_path / (str(data["metadata"]["image_idx"])+'.jpg')
        cv2.imwrite(str(detection_vis_file), bev_map)
        # cv2.waitKey(0)

def initialize(config_path,
               model_dir=None,
               measure_time=True):
    model_dir = str(Path(model_dir).resolve())
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    if isinstance(config_path, str):
        # directly provide a config object. this usually used
        # when you want to eval with several different parameters in
        # one script.
        config = pipeline_pb2.TrainEvalPipelineConfig()
        with open(config_path, "r") as f:
            proto_str = f.read()
            text_format.Merge(proto_str, config)
    else:
        config = config_path

    input_cfg = config.eval_input_reader
    model_cfg = config.model.second
    train_cfg = config.train_config

    net = build_network(model_cfg, measure_time=measure_time).to(device)
    if train_cfg.enable_mixed_precision:
        net.half()
        print("half inference!")
        net.metrics_to_float()
        net.convert_norm_to_float(net)
    target_assigner = net.target_assigner
    voxel_generator = net.voxel_generator
    assert model_dir is not None
    torchplus.train.try_restore_latest_checkpoints(model_dir, [net])

    prep_func = initialize_preprocess_function(
                    input_reader_config=input_cfg,
                    model_config=model_cfg,
                    training=False,
                    voxel_generator=voxel_generator,
                    target_assigner=target_assigner,
                    multi_gpu=False)

    net.eval()
    model = {
            "net": net,
            "prep_func": prep_func
            }

    return model

def evaluate_single_pcd(points,
                        net,
                        prep_func,
                        float_dtype=torch.float32,
                        measure_time=True):
    input_dict = {
        "lidar": {
            "type": "lidar",
            "points": points,
        },
        "metadata": {
            "image_idx": 0 # actually it is lidar frame unique id
        },
    }
    example = prep_func(input_dict=input_dict)
    example["metadata"] = {}
    if "image_idx" in input_dict["metadata"]:
        example["metadata"] = input_dict["metadata"]
    if "anchors_mask" in example:
        example["anchors_mask"] = example["anchors_mask"].astype(np.uint8)
    detections = []
    prep_example_times = []
    prep_times = []
    t2 = time.time()
    t = time.time()
    if measure_time:
        prep_times.append(time.time() - t2)
        torch.cuda.synchronize()
        t1 = time.time()
    example = merge_second_batch([example])
    example = example_convert_to_torch(example, float_dtype)
    if measure_time:
        torch.cuda.synchronize()
        prep_example_times.append(time.time() - t1)
    with torch.no_grad():
        for i in range(100):
            detections += net(example)
    if measure_time:
        t2 = time.time()
        sec_per_example = 100 / (t2-t1)
        print("frame rate:%f"% (sec_per_example))
    return detections


def process(config_path,
            model_dir,
            pcd_path,
            measure_time=True):
    model = initialize(config_path=config_path,
                       model_dir=model_dir,
                       measure_time=measure_time)
    pc_struct, points = PointCloud.from_path(pathlib.Path(pcd_path))
    detection = evaluate_single_pcd(points, model["net"], model["prep_func"])
#    print(detection)
    return detection


def main():
    root_path = '/apollo/voxnet/'
    config_path = root_path + 'second.pytorch.mgpus/second/temp_model4/pipeline.config'
    model_dir = root_path + 'second.pytorch.mgpus/second/temp_model4'
    pcd_file = root_path + 'unit-test-data/US-MKZ9_12_1531265563_1531265623_10/velodyne_points/velodyne64.pcd'
    detection = process(config_path=config_path, model_dir=model_dir, pcd_path=pcd_file)

if __name__ == '__main__':
    main()
#    fire.Fire()
