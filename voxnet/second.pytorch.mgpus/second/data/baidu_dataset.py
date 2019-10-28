import numpy as np
import os
import tarfile
import zipfile
import fire
from copy import deepcopy


from pathlib import Path
import pickle
import time
from functools import partial

from second.core import box_np_ops
from second.core import preprocess as prep
from second.data import baidu_common as baidu
from second.utils.eval import get_baidu_kitti_official_eval_result, get_baidu_coco_eval_result
from second.data.dataset import Dataset, register_dataset
from second.utils.progress_bar import progress_bar_iter as prog_bar

from second.data.baidu_common import get_baidu_info
from second.data.pypcd import PointCloud
from second.data import kitti_common as kitti

@register_dataset
class BaiduDataset(Dataset):
    NumPointFeatures = 4

    def __init__(self, root_path, info_path, class_names=None,  prep_func=None,
    	         num_point_features=None, scenario_list=None,
                 load_pkl=True, do_uncompress=False):

        if not load_pkl or os.path.isfile(info_path) is False:
            load_pkl = False

        if not load_pkl and do_uncompress:
            do_uncompress = True
        else:
            do_uncompress = False

        self._class_names = class_names
        self._do_uncompress = do_uncompress
        self._pcd_name = 'velodyne64.pcd'
        self._root_path = root_path
        self._num_point_features = num_point_features

        self._scenarios = []
        self._label_dir = os.path.join(self._root_path, 'label')
        self._pcd_dir = os.path.join(self._root_path, 'pcd')
        self._labelfile_abs_path = os.path.join(self._label_dir, '{}', '{}.pcd.txt')
        self._pcdfile_abs_path = os.path.join(self._pcd_dir, '{}',
                                          '{}', 'velodyne_points', self._pcd_name)
        self._labelfile_rel_path = os.path.join('label', '{}', '{}.pcd.txt')
        self._pcdfile_rel_path = os.path.join('pcd', '{}',
                                          '{}', 'velodyne_points', self._pcd_name)
        self._infos = []
        self._file_infos = []
        self._label_file_dict = dict()
        self._pcd_file_dict = dict()
        self._delimiter='+-+'
        self._prep_func = prep_func

        if load_pkl:
            with open(info_path, 'rb') as f:
                self._infos = pickle.load(f)
        else:
            self.load_hierarchical_dataset_structure(scenario_list)
                # raise ValueError('cannot load tree-level dataset files')

            self.save_infos(info_path)


    def uncompress_data(self, compressed_file, dst_path, extension='tar.gz'):
        if extension == '.tar.gz':
            tar = tarfile.open(compressed_file, "r:gz")
            tar.extractall(dst_path)
            tar.close()
        elif extension == '.tar':
            tar = tarfile.open(compressed_file, "r:")
            tar.extractall(dst_path)
            tar.close()
        elif extension == '.zip':
            zip = zipfile.ZipFile(compressed_file)
            zip.extractall(dst_path)
            zip.close()
        else:
            raise ValueError('unsupportted compressed file type:{}'.format(extension))

        return True

    def load_hierarchical_dataset_structure(self, info_file):

        with open(info_file, 'r') as f:
            sub_folders = f.readlines()

        self._scenarios = [x.strip() for x in sub_folders]

        for scenario in self._scenarios:
            self._label_file_dict[scenario] = [] #set()
            self._pcd_file_dict[scenario] = [] #set()
            #extract label files
            label_tarfile = os.path.join(self._label_dir, scenario+'.tar.gz')
            if self._do_uncompress:
                self.uncompress_data(label_tarfile, dst_path=self._label_dir,  extension='.tar.gz')
            # build filedict
            scenario_label_dir = os.path.join(self._label_dir, scenario)
            self._label_file_dict[scenario].extend(
                [file[:-8] for file in os.listdir(scenario_label_dir) if file.endswith('.pcd.txt')])
            self._label_file_dict[scenario].sort()

            # extract pcd files
            # top level
            pcd_tarfile = os.path.join(self._pcd_dir, scenario+'.tar.gz')
            if self._do_uncompress:
                self.uncompress_data(pcd_tarfile, dst_path=self._pcd_dir, extension='.tar.gz')
            # second level
            scenario_pcd_dir = os.path.join(self._pcd_dir, scenario)
            self._pcd_file_dict[scenario].extend(
                [file[:-4] for file in os.listdir(scenario_pcd_dir) if file.endswith('.zip')])
            self._pcd_file_dict[scenario].sort()

            for file in self._pcd_file_dict[scenario]:
                pcd_tarfile = os.path.join(scenario_pcd_dir, file+'.zip')
                if self._do_uncompress:
                    self.uncompress_data(pcd_tarfile,
                                         dst_path=os.path.join(scenario_pcd_dir, file),
                                         extension='.zip')

            self._infos.extend(get_baidu_info(root_path=self._root_path,
                                             scenario=scenario,
                                             pcd_files=self._pcd_file_dict[scenario],
                                             label_files=self._label_file_dict[scenario],
                                             pcdfile_rel_path = self._pcdfile_rel_path,
                                             labelfile_rel_path=self._labelfile_rel_path,
                                             num_worker=8))


    def save_infos(self, info_path):
        with open(info_path, 'wb') as f:
            pickle.dump(self._infos, f)

    def get_infos(self):
        return self._infos

    def __len__(self):
        return len(self._infos)

    @property
    def ground_truth_annotations(self):
        if "annos" not in self._infos[0]:
            return None

        gt_annos = []
        for info in self._infos:
            annos = info["annos"]
            N = len(annos["num_points_in_gt"])
            # use occluded to control easy/moderate/hard in kitti
            num_lidar_pts = annos["num_points_in_gt"]
            easy_mask = num_lidar_pts > 15
            moderate_mask = num_lidar_pts > 7
            occluded = np.zeros([N])
            occluded[:] = 2
            occluded[moderate_mask] = 1
            occluded[easy_mask] = 0
            gt_annos.append({
                "bbox":
                np.tile(np.array([[0, 0, 50, 50]]), [N, 1]),
                "alpha":
                np.full(N, -10),
                "occluded":
                occluded,
                "truncated":
                np.zeros(N),
                "name":
                annos["name"],
                "location":
                annos["location"],
                "dimensions":
                annos["dimensions"],
                "rotation_y":
                annos["rotation_y"],
            })
        return gt_annos


    def __getitem__(self, idx):
        input_dict = self.get_sensor_data(idx)
        example = self._prep_func(input_dict=input_dict)
        example["metadata"] = {}
        if "image_idx" in input_dict["metadata"]:
            example["metadata"] = input_dict["metadata"]
        if "anchors_mask" in example:
            example["anchors_mask"] = example["anchors_mask"].astype(np.uint8)
        return example
        #return _read_and_prep_baidu_v2(
            # info=self._infos[idx],
            # root_path=self._root_path,
            # prep_func=self._prep_func)

    def get_sensor_data(self, query):
        idx = query
        if isinstance(query, dict):
            assert "lidar" in query
            idx = query["lidar"]["idx"]

        info = self._infos[idx]
        root_path = self._root_path
        res = {
            "lidar": {
                "type": "lidar",
                "points": None,
            },
            "metadata": {
            	"image_idx": info["image_idx"] # actually it is lidar frame unique id
            },
        }

        pcd_path = Path(info['velodyne_path'])
        pc_struct, points = PointCloud.from_path(Path(root_path) / pcd_path)
        res["lidar"]["points"] = points

        if 'annos' in info:
            annos = info['annos']
            minimum_num_points = 0
            # remove annos with too few points
            annos = kitti.remove_sparse(annos, minimum_num_points)
            # we need other objects to avoid collision when sample
            annos = kitti.remove_dontcare(annos)
            locs = annos["location"]
            dims = annos["dimensions"]
            rots = annos["rotation_y"]
            gt_names = annos["name"]
            # rots = np.concatenate([np.zeros([locs.shape[0], 2], dtype=np.float32), rots], axis=1)
            gt_boxes = np.concatenate([locs, dims, rots[..., np.newaxis]], axis=1).astype(np.float32)
            res["lidar"]["annotations"] = {
                'boxes': gt_boxes,
                'names': gt_names,
            }

        return res



    def evaluation_baidu(self, detections, output_dir):
        """eval by kitti evaluation tool.
        I use num_lidar_pts to set easy, mod, hard.
        easy: num>15, mod: num>7, hard: num>0.
        """
        print("++++++++BaiduDataset KITTI unofficial Evaluation:")
        print(
            "++++++++easy: num_lidar_pts>15, mod: num_lidar_pts>7, hard: num_lidar_pts>0"
        )
        print("++++++++The bbox AP is invalid. Don't forget to ignore it.")
        class_names = self._class_names
        gt_annos = self.ground_truth_annotations
        if gt_annos is None:
            return None
        gt_annos = deepcopy(gt_annos)
        detections = deepcopy(detections)
        dt_annos = []
        for det in detections:
            final_box_preds = det["box3d_lidar"].detach().cpu().numpy()
            label_preds = det["label_preds"].detach().cpu().numpy()
            scores = det["scores"].detach().cpu().numpy()
            anno = kitti.get_start_result_anno()
            num_example = 0
            box3d_lidar = final_box_preds
            for j in range(box3d_lidar.shape[0]):
                anno["bbox"].append(np.array([0, 0, 50, 50]))
                anno["alpha"].append(-10)
                anno["dimensions"].append(box3d_lidar[j, 3:6])
                anno["location"].append(box3d_lidar[j, :3])
                anno["rotation_y"].append(box3d_lidar[j, 6])
                anno["name"].append(class_names[int(label_preds[j])])
                anno["truncated"].append(0.0)
                anno["occluded"].append(0)
                anno["score"].append(scores[j])
                num_example += 1
            if num_example != 0:
                anno = {n: np.stack(v) for n, v in anno.items()}
                dt_annos.append(anno)
            else:
                dt_annos.append(kitti.empty_result_anno())
            num_example = dt_annos[-1]["name"].shape[0]
            dt_annos[-1]["metadata"] = det["metadata"]

        z_axis = 2
        z_center = 0.5
        # for regular raw lidar data, z_axis = 2, z_center = 0.5.
        result_official_dict = get_baidu_kitti_official_eval_result(
            gt_annos,
            dt_annos,
            self._class_names,
            z_axis=z_axis,
            z_center=z_center)
        result_coco = get_baidu_coco_eval_result(
            gt_annos,
            dt_annos,
            self._class_names,
            z_axis=z_axis,
            z_center=z_center)
        return {
            "results": {
                "official": result_official_dict["result"],
                "coco": result_coco["result"],
            },
            "detail": {
                "official": result_official_dict["detail"],
                "coco": result_coco["detail"],
            },
        }


    def evaluation(self, detections, output_dir):
        """
        detection
        When you want to eval your own dataset, you MUST set correct
        the z axis and box z center.
        If you want to eval by my KITTI eval function, you must 
        provide the correct format annotations.
        ground_truth_annotations format:
        {
            bbox: [N, 4], if you fill fake data, MUST HAVE >25 HEIGHT!!!!!!
            alpha: [N], you can use -10 to ignore it.
            occluded: [N], you can use zero.
            truncated: [N], you can use zero.
            name: [N]
            location: [N, 3] center of 3d box.
            dimensions: [N, 3] dim of 3d box.
            rotation_y: [N] angle.
        }
        all fields must be filled, but some fields can fill
        zero.
        """
        return self.evaluation_baidu(detections, output_dir)


def create_baidu_info_file(data_path):
    root_path = Path(data_path)
    train_list = root_path / 'train_list.txt'
    test_list = root_path / 'test_list.txt'
    train_info_file = root_path / 'caches' / 'train_dataset_info.pkl'
    test_info_file = root_path / 'caches' / 'test_dataset_info.pkl'

    baidu_dataset_train = BaiduDataset(info_path=train_info_file,
                                       root_path=root_path,
                                       scenario_list=train_list,
                                       load_pkl=False,
                                       do_uncompress=True)
    print("train info list size: %d " % len(baidu_dataset_train.get_infos()))

    baidu_dataset_test = BaiduDataset(info_path=test_info_file,
                                      root_path=root_path,
                                      scenario_list=test_list,
                                      load_pkl=False,
                                      do_uncompress=True)
    print("test info list size: %d " % len(baidu_dataset_test.get_infos()))	
# def _calculate_num_points_in_gt(data_path,
#                                 infos,
#                                 relative_path,
#                                 remove_outside=True,
#                                 num_features=4):
#     for info in infos:
#         pc_info = info["point_cloud"]
#         image_info = info["image"]
#         if relative_path:
#             v_path = str(Path(data_path) / pc_info["velodyne_path"])
#         else:
#             v_path = pc_info["velodyne_path"]
#         points_v = np.fromfile(
#             v_path, dtype=np.float32, count=-1).reshape([-1, num_features])

#         # points_v = points_v[points_v[:, 0] > 0]
#         annos = info['annos']
#         num_obj = len([n for n in annos['name'] if n != 'DontCare'])
#         # annos = kitti.filter_kitti_anno(annos, ['DontCare'])
#         dims = annos['dimensions'][:num_obj]
#         loc = annos['location'][:num_obj]
#         rots = annos['rotation_y'][:num_obj]
#         gt_boxes_lidar = np.concatenate([loc, dims, rots[..., np.newaxis]],
#                                          axis=1)
#         indices = box_np_ops.points_in_rbbox(points_v[:, :3], gt_boxes_lidar)
#         num_points_in_gt = indices.sum(0)
#         num_ignored = len(annos['dimensions']) - num_obj
#         num_points_in_gt = np.concatenate(
#             [num_points_in_gt, -np.ones([num_ignored])])
#         annos["num_points_in_gt"] = num_points_in_gt.astype(np.int32)




if __name__ == '__main__':
    fire.Fire()
#     root_path = '/home/chenguang09/workspace/dataset/point_cloud/point_cloud_for_us'
#     cache_path = os.path.join(root_path, 'caches')
#     if not os.path.exists(cache_path):
#         os.makedirs(cache_path)

#     info_file = os.path.join(root_path, 'tmp_label.txt')
#     dataset = BaiduDataset(info_file, root_path, 4, target_assigner=None, feature_map_size=None, prep_func=None)
#     dataset_cache_file = os.path.join(cache_path, 'dataset.pkl')
#     output_pkl = open(dataset_cache_file, 'wb')
#     pickle.dump(dataset, output_pkl)

#     gt_summaries = {}
#     for i in range(len(dataset.get_infos())):
#         example = dataset[i]
#         for j, class_name in enumerate(example['gt_names']):
#             if class_name in gt_summaries:
#                 gt_summaries[class_name] = \
#                     np.vstack((gt_summaries[class_name],
#                               example['gt_boxes'][j, :]))
#             else:
#                 gt_summaries[class_name] = \
#                     np.array(example['gt_boxes'][j, :])

#     pickle.dump(gt_summaries, output_pkl)
#     output_pkl.close()

#     print(gt_summaries.keys())
#     print("done")


 