import numpy as np
import pathlib
from second.core.box_np_ops import corner_to_surfaces_3d, points_in_rbbox, center_to_corner_box3d
from second.core.geometry import points_in_convex_polygon_3d_jit
from second.data.pypcd import PointCloud
import concurrent.futures as futures

def get_class_to_label_map():
    class_to_label = {
        'smallMot': 0,
        'bigMot': 1,
        'bicyclist': 2,
        'motorcyclist': 3,
        'others': 4,
        'TrafficCone': 5,
        'pedestrian': 6,
        'DontCare': -1,
    }
    return class_to_label


def get_classes():
    return get_class_to_label_map().keys()


def _generate_info_dict_baidu_v1(root_path, label_path, pcd_path, count_num_points=False):

    pc_struct, points = PointCloud.from_path(pathlib.Path(root_path) / pcd_path)
    annos = load_baidu_label_file(pathlib.Path(root_path) / label_path)
    if count_num_points:
        dims = annos['dimensions']
        loc = annos['location']
        rots = annos['rotation_y']
        # rots = -rots
        gt_boxes_lidar = np.concatenate([loc, dims, rots[..., np.newaxis]],
                                        axis=1)
        indices2 = points_in_rbbox(points[:, :3], gt_boxes_lidar)
        num_points_in_gt2 = indices2.sum(0)

        #rbbox_corners = center_to_corner_box3d(
        #    gt_boxes_lidar[:, :3], gt_boxes_lidar[:, 3:6], gt_boxes_lidar[:, 6])

        bbox_corners = annos['corners']
        surfaces = corner_to_surfaces_3d(bbox_corners)
        indices = points_in_convex_polygon_3d_jit(points[:, :3], surfaces)
        num_points_in_gt = indices.sum(0)
        annos.update({
            "num_points_in_gt": num_points_in_gt
        })

        if not np.array_equal(num_points_in_gt, num_points_in_gt2) or\
            not np.array_equal(indices, indices2):
            # raise ValueError("The rotation is wrong %s" % label_path)
            print ("%s mismatch points: %d" %(label_path, np.sum(num_points_in_gt2-num_points_in_gt)))
            print("%s mismatch points: %d" % (label_path, np.sum(indices2.astype(np.int) - indices.astype(np.int))))


    return annos

def get_baidu_info(root_path,
                   scenario,
                   pcd_files,
                   label_files,
                   pcdfile_rel_path,
                   labelfile_rel_path,
                   num_worker=8):

    if len(pcd_files) != len(label_files):
        raise ValueError("scenario {} does not have equal label number and pcd number".format(scenario))

    indexes = list(range(len(pcd_files)))
    # print ("indexes are: {}".format(indexes))
    print("scenarios %s : %d : " % (scenario, len(indexes)))

    def map_func(idx): # scenario, pcdfile_rel_path, , labelfile_rel_path):
        # add dummy information for consistent with Kitti
        info ={
            'pointcloud_num_features': 4,
            # 'img_path': None,
            # 'img_shape': None,
            # 'calib/P0': np.zeros([3, 4], dtype=np.float32),
            # 'calib/P1': np.zeros([3, 4], dtype=np.float32),
            # 'calib/P2': np.zeros([3, 4], dtype=np.float32),
            # 'calib/P3': np.zeros([3, 4], dtype=np.float32),
            # 'calib/R0_rect': np.zeros([4, 4], dtype=np.float32),
            # 'calib/Tr_velo_to_cam': np.zeros([3, 4], dtype=np.float32),
            # 'calib/Tr_imu_to_velo':  np.zeros([3, 4], dtype=np.float32)
        }

        pcd = pcd_files[idx]
        p0 = pcd.rfind('_')
        p1 = pcd.rfind('_', 0, p0)
        string1 = pcd[0:p1] + pcd[p0:]
        lbl = label_files[idx]
        p0 = lbl.rfind('_')
        p1 = lbl.rfind('_', 0, p0)
        string2 = lbl[0:p1] + lbl[p0:]
        if string1 != string2:
            raise ValueError("label name not same as pcd name:{}, {}".format(string1, string2))

        info.update({
            'image_idx': string1,
            'velodyne_path': pcdfile_rel_path.format(scenario, pcd_files[idx]),
            'label_path': labelfile_rel_path.format(scenario, label_files[idx])
        })

        # print("%d / %d: " % (idx, len(indexes)))
        # print(info['label_path'])

        info['annos'] = _generate_info_dict_baidu_v1(root_path,
                                                     info['label_path'],
                                                     info['velodyne_path'],
                                                     count_num_points=True)
        return info

    with futures.ThreadPoolExecutor(num_worker) as executor:
        infos = executor.map(map_func, indexes)
    return list(infos)

def is_dont_care(center, wlh, theta, class_name):
    return False


def load_baidu_label_file(label_path):
    annos = {}
    annos["location"] = []
    annos["dimensions"] = []
    annos["rotation_y"] = []
    annos["name"] = []
    annos["difficulty"] =[]
    annos["corners"]=[]
    annos["index"] = []
    # annos["bbox"] = []  # for lidar only, bbox is simply birdview bbox
    index_count = 0
    with open(label_path,'r') as f:
        # line = f.readline()
        for line in f:
            gt = line.rstrip().split(' ')
            if len(gt) is not 25: # class type + 8 points
                raise ValueError("ground truth length {} not equals to 25".format(len(gt)))

            class_name =str(gt[0])
            coords = [float(i) for i in gt[1:]]

            lower_z = coords[2]
            upper_z = coords[3*4+2]
            height = np.absolute(upper_z - lower_z)
            width = np.sqrt((coords[0] - coords[3*1+0])**2 +
                            (coords[1] - coords[3*1+1])**2)
            length = np.sqrt((coords[3*2+0] - coords[3*1+0])**2 +
                             (coords[3*2+1] - coords[3*1+1])**2)
            center = [(coords[0]+coords[3*6])/2,
                      (coords[1]+coords[3*6+1])/2,
                      (coords[2]+coords[3*6+2])/2]
            theta = np.arctan2(coords[1]-coords[3*3+1], coords[0]-coords[3*3])
            ### -------CAUTION --------####
            # the reason do a reverse, is the box_np_ops, when rotate rotation_3d_in_axis,
            # should take rotation_matrix.transpose(), when put points in front,
            # #like points * rotation_matrix.transpose(),
            # or , use rotaiton_matrix * points
            theta = -theta
            ### --------------------####
            if width < 1e-3 or length < 1e-3 or height < 1e-3:
                raise ValueError(
                    "Warning: bbox too small to use {}, {}, {}".format(width, length, height))

            # wlh = [width, length, height]
            # lidar x axis corresponds to length, y axis is width, same as in KITTI paper
            lwh = [length, width, height]

            if is_dont_care(center, lwh, theta, class_name):
                class_name = 'DontCare'
                class_idx = -1
            else:
               class_idx = index_count
               index_count += 1

            annos["location"].append(center)
            annos["dimensions"].append(lwh)
            annos["rotation_y"].append(theta)
            annos["name"].append(class_name)
            annos["difficulty"].append(0)
            annos["corners"].append(np.reshape(coords, [-1, 3]))
            annos["index"].append(class_idx)
            # corners_2d = annos["corners"][-1][:, :2]
            # minxy = np.min(corners_2d, axis=0)
            # maxxy = np.max(corners_2d, axis=0)
            # annos["bbox"].append(np.hstack([minxy, maxxy]))


    annos["location"] = np.array(annos["location"])
    annos["dimensions"] = np.array(annos["dimensions"])
    annos["rotation_y"] = np.array(annos["rotation_y"])
    num_objects = len([x for x in annos["name"] if x!='DontCare'])
    annos["name"] = np.array(annos["name"])
    num_gt = len(annos["name"])
    annos["index"] = np.array(annos["index"], dtype=np.int32)
    annos["difficulty"] = np.array(annos["difficulty"])
    annos["group_ids"] = np.arange(num_gt, dtype=np.int32)
    annos["corners"] = np.array(annos["corners"], dtype=np.float32)
    # annos["bbox"] = np.array(annos["bbox"], dtype=np.float32)

    return annos