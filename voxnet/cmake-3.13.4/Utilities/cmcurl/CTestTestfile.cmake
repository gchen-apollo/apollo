# CMake generated Testfile for 
# Source directory: /apollo/voxnet/cmake-3.13.4/Utilities/cmcurl
# Build directory: /apollo/voxnet/cmake-3.13.4/Utilities/cmcurl
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(curl "curltest" "http://open.cdash.org/user.php")
subdirs("lib")
