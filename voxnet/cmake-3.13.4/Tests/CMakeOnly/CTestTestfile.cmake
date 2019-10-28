# CMake generated Testfile for 
# Source directory: /apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly
# Build directory: /apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(CMakeOnly.LinkInterfaceLoop "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=LinkInterfaceLoop" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
set_tests_properties(CMakeOnly.LinkInterfaceLoop PROPERTIES  TIMEOUT "90")
add_test(CMakeOnly.CheckSymbolExists "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CheckSymbolExists" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckCXXSymbolExists "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CheckCXXSymbolExists" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckCXXCompilerFlag "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CheckCXXCompilerFlag" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckLanguage "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CheckLanguage" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CheckStructHasMember "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CheckStructHasMember" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CompilerIdC "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CompilerIdC" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CompilerIdCXX "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CompilerIdCXX" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.CompilerIdFortran "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=CompilerIdFortran" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.AllFindModules "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=AllFindModules" "-DCMAKE_ARGS=-DCMake_TEST_CMakeOnly.AllFindModules_NO_VERSION=" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.SelectLibraryConfigurations "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=SelectLibraryConfigurations" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.TargetScope "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=TargetScope" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.find_library "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=find_library" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.find_path "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=find_path" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.ProjectInclude "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=ProjectInclude" "-DCMAKE_ARGS=-DCMAKE_PROJECT_ProjectInclude_INCLUDE=/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/ProjectInclude/include.cmake" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonLibs_2 "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=MajorVersionSelection-PythonLibs_2" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonLibs;-DMAJOR_TEST_VERSION=2;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=PYTHONLIBS_VERSION_STRING" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonLibs_3 "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=MajorVersionSelection-PythonLibs_3" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonLibs;-DMAJOR_TEST_VERSION=3;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=PYTHONLIBS_VERSION_STRING" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonInterp_2 "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=MajorVersionSelection-PythonInterp_2" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonInterp;-DMAJOR_TEST_VERSION=2;-DMAJOR_TEST_NO_LANGUAGES=TRUE;-DMAJOR_TEST_VERSION_VAR=PYTHON_VERSION_STRING" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-PythonInterp_3 "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=MajorVersionSelection-PythonInterp_3" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=PythonInterp;-DMAJOR_TEST_VERSION=3;-DMAJOR_TEST_NO_LANGUAGES=TRUE;-DMAJOR_TEST_VERSION_VAR=PYTHON_VERSION_STRING" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-Qt_3 "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=MajorVersionSelection-Qt_3" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=Qt;-DMAJOR_TEST_VERSION=3;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=QT_VERSION_STRING" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
add_test(CMakeOnly.MajorVersionSelection-Qt_4 "/apollo/voxnet/cmake-3.13.4/bin/cmake" "-DTEST=MajorVersionSelection-Qt_4" "-DTEST_SOURCE=MajorVersionSelection" "-DCMAKE_ARGS=-DMAJOR_TEST_MODULE=Qt;-DMAJOR_TEST_VERSION=4;-DMAJOR_TEST_NO_LANGUAGES=FALSE;-DMAJOR_TEST_VERSION_VAR=QT_VERSION_STRING" "-P" "/apollo/voxnet/cmake-3.13.4/Tests/CMakeOnly/Test.cmake")
