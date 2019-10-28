
"""
Read and write PCL .pcd files in python.
@chenguang, 2019
TODO deal properly with padding
TODO deal properly with multicount fields
TODO better support for rgb nonsense
"""

import re
import struct
import copy
from io import StringIO as sio
import numpy as np
import warnings
import lzf


numpy_pcd_type_mappings = [(np.dtype('float32'), ('F', 4)),
                           (np.dtype('float64'), ('F', 8)),
                           (np.dtype('uint8'), ('U', 1)),
                           (np.dtype('uint16'), ('U', 2)),
                           (np.dtype('uint32'), ('U', 4)),
                           (np.dtype('uint64'), ('U', 8)),
                           (np.dtype('int16'), ('I', 2)),
                           (np.dtype('int32'), ('I', 4)),
                           (np.dtype('int64'), ('I', 8))]
numpy_type_to_pcd_type = dict(numpy_pcd_type_mappings)
pcd_type_to_numpy_type = dict((q, p) for (p, q) in numpy_pcd_type_mappings)

class PointCloud(object):
        def __init__(self, metadata, pc_data, num_feature=4):
            self.metadata_keys = metadata.keys()
            self.__dict__.update(metadata)
            self.pc_data = pc_data
            self.num_feature = num_feature
            self.check_sanity()

        def get_metadata(self):
            """ returns copy of metadata """
            metadata = {}
            for k in self.metadata_keys:
                metadata[k] = copy.copy(getattr(self, k))
            return metadata

        def check_sanity(self):
            # pdb.set_trace()
            md = self.get_metadata()
            assert (_metadata_is_consistent(md))
            assert (len(self.pc_data) == self.points)
            assert (self.width * self.height == self.points)
            assert (len(self.fields) == len(self.count))
            assert (len(self.fields) == len(self.type))

        # def save(self, fname):
        #     self.save_pcd(fname, 'ascii')
        #
        # def save_pcd(self, fname, compression=None, **kwargs):
        #     if 'data_compression' in kwargs:
        #         warnings.warn('data_compression keyword is deprecated for'
        #                       ' compression')
        #         compression = kwargs['data_compression']
        #     with open(fname, 'wb') as f:
        #         point_cloud_to_fileobj(self, f, compression)
        #
        # def save_pcd_to_fileobj(self, fileobj, compression=None, **kwargs):
        #     if 'data_compression' in kwargs:
        #         warnings.warn('data_compression keyword is deprecated for'
        #                       ' compression')
        #         compression = kwargs['data_compression']
        #     point_cloud_to_fileobj(self, fileobj, compression)
        #
        # def save_pcd_to_buffer(self, compression=None, **kwargs):
        #     if 'data_compression' in kwargs:
        #         warnings.warn('data_compression keyword is deprecated for'
        #                       ' compression')
        #         compression = kwargs['data_compression']
        #     return point_cloud_to_buffer(self, compression)

        # def save_txt(self, fname):
        #     save_txt(self, fname)
        #
        # def save_xyz_label(self, fname, **kwargs):
        #     save_xyz_label(self, fname, **kwargs)
        #
        # def save_xyz_intensity_label(self, fname, **kwargs):
        #     save_xyz_intensity_label(self, fname, **kwargs)

        def copy(self):
            new_pc_data = np.copy(self.pc_data)
            new_metadata = self.get_metadata()
            return PointCloud(new_metadata, new_pc_data)

        # def to_msg(self):
        #     if not HAS_SENSOR_MSGS:
        #         raise NotImplementedError('ROS sensor_msgs not found')
        #     # TODO is there some metadata we want to attach?
        #     return numpy_pc2.array_to_pointcloud2(self.pc_data)

        @staticmethod
        def from_path(fname):
            return point_cloud_from_path(fname)

        @staticmethod
        def from_fileobj(fileobj):
            return point_cloud_from_fileobj(fileobj)


def _build_dtype(metadata):
    """ build numpy structured array dtype from pcl metadata.
    note that fields with count > 1 are 'flattened' by creating multiple
    single-count fields.
    TODO: allow 'proper' multi-count fields.
    """
    fieldnames = []
    typenames = []
    for f, c, t, s in zip(metadata['fields'],
                          metadata['count'],
                          metadata['type'],
                          metadata['size']):
        np_type = pcd_type_to_numpy_type[(t, s)]
        if c == 1:
            fieldnames.append(f)
            typenames.append(np_type)
        else:
            fieldnames.extend(['%s_%04d' % (f, i) for i in range(c)])
            typenames.extend([np_type]*c)
    dtype = np.dtype(list(zip(fieldnames, typenames)))
    return dtype


def point_cloud_from_fileobj(f):
        """ parse pointcloud coming from file object f
        """
        header = []
        while True:
            ln = f.readline().strip()
            if not isinstance(ln, str):
                ln = ln.decode('utf-8')
            header.append(ln)
            if ln.startswith('DATA'):
                metadata = parse_header(header)
                dtype = _build_dtype(metadata)
                break
        if metadata['data'] == 'ascii':
            pc_data = parse_ascii_pc_data(f, dtype, metadata)
        elif metadata['data'] == 'binary':
            pc_data = parse_binary_pc_data(f, dtype, metadata)
        elif metadata['data'] == 'binary_compressed':
            pc_data = parse_binary_compressed_pc_data(f, dtype, metadata)
        else:
            print('DATA field is neither "ascii" or "binary" or\
                    "binary_compressed"')
        return PointCloud(metadata, pc_data)


def point_cloud_from_path(fname):
        """ load point cloud in binary format
        """
        with open(fname, 'rb') as f:
            pc = point_cloud_from_fileobj(f)
            points = np.zeros([pc.pc_data.size,4], dtype=np.float32)
            points[:, 0] = pc.pc_data[:]['x']
            points[:, 1] = pc.pc_data[:]['y']
            points[:, 2] = pc.pc_data[:]['z']
            points[:, 3] = pc.pc_data[:]['intensity']/255
        return pc, points


def parse_header(lines):
    metadata = {}
    for ln in lines:
        if ln.startswith('#') or len(ln) < 2:
            continue
        match = re.match('(\w+)\s+([\w\s\.]+)', ln)
        if not match:
            warnings.warn("warning: can't understand line: %s" % ln)
            continue
        key, value = match.group(1).lower(), match.group(2)
        if key == 'version':
            metadata[key] = value
        elif key in ('fields', 'type'):
            metadata[key] = value.split()
        elif key in ('size', 'count'):
            metadata[key] = list(map(int, value.split()))
        elif key in ('width', 'height', 'points'):
            metadata[key] = int(value)
        elif key == 'viewpoint':
            metadata[key] = list(map(float, value.split()))
        elif key == 'data':
            metadata[key] = value.strip().lower()
        # TODO apparently count is not required?
    # add some reasonable defaults
    if 'count' not in metadata:
        metadata['count'] = [1]*len(metadata['fields'])
    if 'viewpoint' not in metadata:
        metadata['viewpoint'] = [0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0]
    if 'version' not in metadata:
        metadata['version'] = '.7'
    return metadata


def parse_ascii_pc_data(f, dtype, metadata):
    return np.loadtxt(f, dtype=dtype, delimiter=' ')


def parse_binary_pc_data(f, dtype, metadata):
    rowstep = metadata['points']*dtype.itemsize
    # for some reason pcl adds empty space at the end of files
    buf = f.read(rowstep)
    return np.fromstring(buf, dtype=dtype)


def parse_binary_compressed_pc_data(f, dtype, metadata):
    # compressed size of data (uint32)
    # uncompressed size of data (uint32)
    # compressed data
    # junk
    fmt = 'II'
    compressed_size, uncompressed_size =\
        struct.unpack(fmt, f.read(struct.calcsize(fmt)))
    compressed_data = f.read(compressed_size)
    # TODO what to use as second argument? if buf is None
    # (compressed > uncompressed)
    # should we read buf as raw binary?
    buf = lzf.decompress(compressed_data, uncompressed_size)
    if len(buf) != uncompressed_size:
        raise Exception('Error decompressing data')
    # the data is stored field-by-field
    pc_data = np.zeros(metadata['width'], dtype=dtype)
    ix = 0
    for dti in range(len(dtype)):
        dt = dtype[dti]
        bytes = dt.itemsize * metadata['width']
        column = np.fromstring(buf[ix:(ix+bytes)], dt)
        pc_data[dtype.names[dti]] = column
        ix += bytes
    return pc_data

      # dtype=[('x', '<f4'), ('y', '<f4'), ('z', '<f4'), ('intensity', 'u1'), ('timestamp', '<f8')])
# for elem in pc_data:
#     max_elem[0][0] = np.maximum(max_elem[0][0], elem[0])
#     min_elem[0][0] = np.minimum(min_elem[0][0], elem[0])
#     max_elem[0][1] = np.maximum(max_elem[0][1], elem[1])
#     min_elem[0][1] = np.minimum(min_elem[0][1], elem[1])
#     max_elem[0][2] = np.maximum(max_elem[0][2], elem[2])
#     min_elem[0][2] = np.minimum(min_elem[0][2], elem[2])
#     max_elem[0][3] = np.maximum(max_elem[0][3], elem[3])
#     min_elem[0][3] = np.minimum(min_elem[0][3], elem[3])


def _metadata_is_consistent(metadata):
    """ sanity check for metadata. just some basic checks.
    """
    checks = []
    required = ('version', 'fields', 'size', 'width', 'height', 'points',
                'viewpoint', 'data')
    for f in required:
        if f not in metadata:
            print('%s required' % f)
    checks.append((lambda m: all([k in m for k in required]),
                   'missing field'))
    checks.append((lambda m: len(m['type']) == len(m['count']) ==
                   len(m['fields']),
                   'length of type, count and fields must be equal'))
    checks.append((lambda m: m['height'] > 0,
                   'height must be greater than 0'))
    checks.append((lambda m: m['width'] > 0,
                   'width must be greater than 0'))
    checks.append((lambda m: m['points'] > 0,
                   'points must be greater than 0'))
    checks.append((lambda m: m['data'].lower() in ('ascii', 'binary',
                   'binary_compressed'),
                   'unknown data type:'
                   'should be ascii/binary/binary_compressed'))
    ok = True
    for check, msg in checks:
        if not check(metadata):
            print('error:', msg)
            ok = False

    return ok


if __name__ == '__main__':
    pcd_file = '/home/chenguang09/workspace/dataset/point_cloud/point_cloud_for_us/pcd/mark_task_6684/US-MKZ9_12_1531265563_1531265623_10/velodyne_points/velodyne64.pcd'
    pcd = PointCloud.from_path(pcd_file)
