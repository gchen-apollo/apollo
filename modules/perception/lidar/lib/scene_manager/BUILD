load("//tools:cpplint.bzl", "cpplint")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "scene_manager",
    srcs = ["scene_manager.cc"],
    hdrs = ["scene_manager.h"],
    deps = [
        ":scene_service",
        "//modules/common/util",
        "//modules/perception/lib/config_manager",
        "//modules/perception/lib/thread",
        "//modules/perception/lidar/lib/scene_manager/proto:scene_manager_config_proto",
        "//modules/perception/proto:perception_config_schema_proto",
    ],
)

cc_library(
    name = "scene_service",
    hdrs = ["scene_service.h"],
    deps = [
        "//modules/perception/lib/registerer",
    ],
)

cc_test(
    name = "scene_manager_test",
    size = "small",
    srcs = ["scene_manager_test.cc"],
    deps = [
        ":scene_manager",
        "//modules/map/hdmap",
        "//modules/map/proto:map_proto",
        "//modules/perception/base",
        "//modules/perception/common:perception_gflags",
        "//modules/perception/common/io:io_util",
        "//modules/perception/lidar/common",
        "//modules/perception/lidar/lib/interface",
        "//modules/perception/lidar/lib/roi_filter/hdmap_roi_filter",
        "//modules/perception/lidar/lib/scene_manager/ground_service",
        "//modules/perception/lidar/lib/scene_manager/roi_service",
        "//modules/perception/map/hdmap:hdmap_input",
        "@gtest//:main",
        "@pcl",
    ],
)

cpplint()
