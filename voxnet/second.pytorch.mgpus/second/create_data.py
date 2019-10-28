import copy
from pathlib import Path
import pickle
import numpy as np
import fire

import second.data.kitti_dataset as kitti_ds
import second.data.nuscenes_dataset as nu_ds
import second.data.baidu_dataset as baidu_ds
from second.data.all_dataset import create_groundtruth_database


def kitti_data_prep(root_path):
    kitti_ds.create_kitti_info_file(root_path)
    kitti_ds.create_reduced_point_cloud(root_path)
    create_groundtruth_database("KittiDataset", root_path, Path(root_path) / "kitti_infos_train.pkl")


def nuscenes_data_prep(root_path, version, dataset_name, max_sweeps=10):
    nu_ds.create_nuscenes_infos(root_path, version=version, max_sweeps=max_sweeps)
    name = "infos_train.pkl"
    if version == "v1.0-test":
        name = "infos_test.pkl"
    create_groundtruth_database(dataset_name, root_path, Path(root_path) / name)


def baidu_data_prep(root_path):
    baidu_ds.create_baidu_info_file(root_path)
    info_path = Path(root_path) / 'caches' / 'train_dataset_info.pkl'
    db_info_save_path = Path(root_path) / 'caches' / 'baidu_dbinfos_train.pkl'
    create_groundtruth_database(dataset_class_name="BaiduDataset",
                                data_path=root_path,
                                info_path=info_path,
                                db_info_save_path=db_info_save_path
                                )

def baidu_groundtruth_analysis(root_path):
    info_path = Path(root_path) / 'caches' / 'test_dataset_info.pkl'
    with open(info_path, 'rb') as f:
        infos= pickle.load(f)

    all_gt_boxes = {
        'smallMot': [],
        'bigMot': [],
        'bicyclist': [],
        'motorcyclist': [],
        'others': [],
        'TrafficCone': [],
        'pedestrian': [],
    }
    minimum_points = {
        'smallMot': 15,
        'bigMot': 20,
        'bicyclist': 10,
        'motorcyclist': 10,
        'others': 10,
        'TrafficCone': 10,
        'pedestrian': 10,
    }
    gt_means = {}
    for info in infos:
        annos = info['annos']
        locs = annos["location"]
        dims = annos["dimensions"]
        rots = annos["rotation_y"]
        num_points_in_gt = annos["num_points_in_gt"]
        gt_names = annos["name"]
        gt_boxes = np.concatenate([locs, dims, rots[..., np.newaxis], num_points_in_gt[..., np.newaxis]], axis=1).astype(np.float32)
        for i, name in enumerate(gt_names):
            if gt_boxes[i, -1] >= minimum_points[name]:
                all_gt_boxes[name].append(gt_boxes[i, :])
    np.set_printoptions(precision=3, suppress=True)

    for name in all_gt_boxes.keys():
        all_gt_boxes[name] = np.stack(all_gt_boxes[name], axis=0)
        gt_means[name] = np.mean(all_gt_boxes[name], axis=0)
        print('{}: {}, gt_num:{}'.format(name, gt_means[name][2:], all_gt_boxes[name].shape[0]))
    gt_summary_pkl = Path(root_path) / 'caches' / 'gt_summary.pkl'
    with open(gt_summary_pkl, 'wb') as f:
        pickle.dump(all_gt_boxes, f)

if __name__ == '__main__':
    fire.Fire()
