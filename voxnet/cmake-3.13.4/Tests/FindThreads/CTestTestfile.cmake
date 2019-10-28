# CMake generated Testfile for 
# Source directory: /apollo/voxnet/cmake-3.13.4/Tests/FindThreads
# Build directory: /apollo/voxnet/cmake-3.13.4/Tests/FindThreads
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(FindThreads.C-only "/apollo/voxnet/cmake-3.13.4/bin/ctest" "--build-and-test" "/apollo/voxnet/cmake-3.13.4/Tests/FindThreads/C-only" "/apollo/voxnet/cmake-3.13.4/Tests/FindThreads/C-only" "--build-generator" "Unix Makefiles" "--build-project" "FindThreads_C-only" "--build-options" "-DCMAKE_MAKE_PROGRAM:FILEPATH=/usr/bin/make" "--test-command" "/apollo/voxnet/cmake-3.13.4/bin/ctest" "-V")
add_test(FindThreads.CXX-only "/apollo/voxnet/cmake-3.13.4/bin/ctest" "--build-and-test" "/apollo/voxnet/cmake-3.13.4/Tests/FindThreads/CXX-only" "/apollo/voxnet/cmake-3.13.4/Tests/FindThreads/CXX-only" "--build-generator" "Unix Makefiles" "--build-project" "FindThreads_CXX-only" "--build-options" "-DCMAKE_MAKE_PROGRAM:FILEPATH=/usr/bin/make" "--test-command" "/apollo/voxnet/cmake-3.13.4/bin/ctest" "-V")
