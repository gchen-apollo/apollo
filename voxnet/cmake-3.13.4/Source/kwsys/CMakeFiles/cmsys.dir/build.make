# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /apollo/voxnet/cmake-3.13.4/Bootstrap.cmk/cmake

# The command to remove a file.
RM = /apollo/voxnet/cmake-3.13.4/Bootstrap.cmk/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /apollo/voxnet/cmake-3.13.4

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /apollo/voxnet/cmake-3.13.4

# Include any dependencies generated for this target.
include Source/kwsys/CMakeFiles/cmsys.dir/depend.make

# Include the progress variables for this target.
include Source/kwsys/CMakeFiles/cmsys.dir/progress.make

# Include the compile flags for this target's objects.
include Source/kwsys/CMakeFiles/cmsys.dir/flags.make

Source/kwsys/CMakeFiles/cmsys.dir/ProcessUNIX.c.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/ProcessUNIX.c.o: Source/kwsys/ProcessUNIX.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object Source/kwsys/CMakeFiles/cmsys.dir/ProcessUNIX.c.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_C_HAS_PTRDIFF_T=1 -DKWSYS_C_HAS_SSIZE_T=1 -DKWSYS_C_HAS_CLOCK_GETTIME_MONOTONIC=1 -o CMakeFiles/cmsys.dir/ProcessUNIX.c.o   -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/ProcessUNIX.c

Source/kwsys/CMakeFiles/cmsys.dir/ProcessUNIX.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cmsys.dir/ProcessUNIX.c.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_C_HAS_PTRDIFF_T=1 -DKWSYS_C_HAS_SSIZE_T=1 -DKWSYS_C_HAS_CLOCK_GETTIME_MONOTONIC=1 -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/ProcessUNIX.c > CMakeFiles/cmsys.dir/ProcessUNIX.c.i

Source/kwsys/CMakeFiles/cmsys.dir/ProcessUNIX.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cmsys.dir/ProcessUNIX.c.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_C_HAS_PTRDIFF_T=1 -DKWSYS_C_HAS_SSIZE_T=1 -DKWSYS_C_HAS_CLOCK_GETTIME_MONOTONIC=1 -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/ProcessUNIX.c -o CMakeFiles/cmsys.dir/ProcessUNIX.c.s

Source/kwsys/CMakeFiles/cmsys.dir/Base64.c.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/Base64.c.o: Source/kwsys/Base64.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object Source/kwsys/CMakeFiles/cmsys.dir/Base64.c.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/cmsys.dir/Base64.c.o   -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/Base64.c

Source/kwsys/CMakeFiles/cmsys.dir/Base64.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cmsys.dir/Base64.c.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/Base64.c > CMakeFiles/cmsys.dir/Base64.c.i

Source/kwsys/CMakeFiles/cmsys.dir/Base64.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cmsys.dir/Base64.c.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/Base64.c -o CMakeFiles/cmsys.dir/Base64.c.s

Source/kwsys/CMakeFiles/cmsys.dir/EncodingC.c.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/EncodingC.c.o: Source/kwsys/EncodingC.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object Source/kwsys/CMakeFiles/cmsys.dir/EncodingC.c.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) -DKWSYS_ENCODING_DEFAULT_CODEPAGE=CP_UTF8 $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/cmsys.dir/EncodingC.c.o   -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/EncodingC.c

Source/kwsys/CMakeFiles/cmsys.dir/EncodingC.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cmsys.dir/EncodingC.c.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) -DKWSYS_ENCODING_DEFAULT_CODEPAGE=CP_UTF8 $(C_INCLUDES) $(C_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/EncodingC.c > CMakeFiles/cmsys.dir/EncodingC.c.i

Source/kwsys/CMakeFiles/cmsys.dir/EncodingC.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cmsys.dir/EncodingC.c.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) -DKWSYS_ENCODING_DEFAULT_CODEPAGE=CP_UTF8 $(C_INCLUDES) $(C_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/EncodingC.c -o CMakeFiles/cmsys.dir/EncodingC.c.s

Source/kwsys/CMakeFiles/cmsys.dir/MD5.c.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/MD5.c.o: Source/kwsys/MD5.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object Source/kwsys/CMakeFiles/cmsys.dir/MD5.c.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/cmsys.dir/MD5.c.o   -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/MD5.c

Source/kwsys/CMakeFiles/cmsys.dir/MD5.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cmsys.dir/MD5.c.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/MD5.c > CMakeFiles/cmsys.dir/MD5.c.i

Source/kwsys/CMakeFiles/cmsys.dir/MD5.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cmsys.dir/MD5.c.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/MD5.c -o CMakeFiles/cmsys.dir/MD5.c.s

Source/kwsys/CMakeFiles/cmsys.dir/Terminal.c.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/Terminal.c.o: Source/kwsys/Terminal.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object Source/kwsys/CMakeFiles/cmsys.dir/Terminal.c.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/cmsys.dir/Terminal.c.o   -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/Terminal.c

Source/kwsys/CMakeFiles/cmsys.dir/Terminal.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cmsys.dir/Terminal.c.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/Terminal.c > CMakeFiles/cmsys.dir/Terminal.c.i

Source/kwsys/CMakeFiles/cmsys.dir/Terminal.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cmsys.dir/Terminal.c.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/Terminal.c -o CMakeFiles/cmsys.dir/Terminal.c.s

Source/kwsys/CMakeFiles/cmsys.dir/System.c.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/System.c.o: Source/kwsys/System.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object Source/kwsys/CMakeFiles/cmsys.dir/System.c.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_C_HAS_PTRDIFF_T=1 -DKWSYS_C_HAS_SSIZE_T=1 -DKWSYS_C_HAS_CLOCK_GETTIME_MONOTONIC=1 -o CMakeFiles/cmsys.dir/System.c.o   -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/System.c

Source/kwsys/CMakeFiles/cmsys.dir/System.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cmsys.dir/System.c.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_C_HAS_PTRDIFF_T=1 -DKWSYS_C_HAS_SSIZE_T=1 -DKWSYS_C_HAS_CLOCK_GETTIME_MONOTONIC=1 -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/System.c > CMakeFiles/cmsys.dir/System.c.i

Source/kwsys/CMakeFiles/cmsys.dir/System.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cmsys.dir/System.c.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_C_HAS_PTRDIFF_T=1 -DKWSYS_C_HAS_SSIZE_T=1 -DKWSYS_C_HAS_CLOCK_GETTIME_MONOTONIC=1 -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/System.c -o CMakeFiles/cmsys.dir/System.c.s

Source/kwsys/CMakeFiles/cmsys.dir/String.c.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/String.c.o: Source/kwsys/String.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object Source/kwsys/CMakeFiles/cmsys.dir/String.c.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_STRING_C -o CMakeFiles/cmsys.dir/String.c.o   -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/String.c

Source/kwsys/CMakeFiles/cmsys.dir/String.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/cmsys.dir/String.c.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_STRING_C -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/String.c > CMakeFiles/cmsys.dir/String.c.i

Source/kwsys/CMakeFiles/cmsys.dir/String.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/cmsys.dir/String.c.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -DKWSYS_STRING_C -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/String.c -o CMakeFiles/cmsys.dir/String.c.s

Source/kwsys/CMakeFiles/cmsys.dir/Directory.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/Directory.cxx.o: Source/kwsys/Directory.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/Directory.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/Directory.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/Directory.cxx

Source/kwsys/CMakeFiles/cmsys.dir/Directory.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/Directory.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/Directory.cxx > CMakeFiles/cmsys.dir/Directory.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/Directory.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/Directory.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/Directory.cxx -o CMakeFiles/cmsys.dir/Directory.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/DynamicLoader.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/DynamicLoader.cxx.o: Source/kwsys/DynamicLoader.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/DynamicLoader.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) -DKWSYS_SUPPORTS_SHARED_LIBS=1 $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/DynamicLoader.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/DynamicLoader.cxx

Source/kwsys/CMakeFiles/cmsys.dir/DynamicLoader.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/DynamicLoader.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_SUPPORTS_SHARED_LIBS=1 $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/DynamicLoader.cxx > CMakeFiles/cmsys.dir/DynamicLoader.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/DynamicLoader.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/DynamicLoader.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_SUPPORTS_SHARED_LIBS=1 $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/DynamicLoader.cxx -o CMakeFiles/cmsys.dir/DynamicLoader.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/EncodingCXX.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/EncodingCXX.cxx.o: Source/kwsys/EncodingCXX.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/EncodingCXX.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) -DKWSYS_ENCODING_DEFAULT_CODEPAGE=CP_UTF8 $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/EncodingCXX.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/EncodingCXX.cxx

Source/kwsys/CMakeFiles/cmsys.dir/EncodingCXX.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/EncodingCXX.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_ENCODING_DEFAULT_CODEPAGE=CP_UTF8 $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/EncodingCXX.cxx > CMakeFiles/cmsys.dir/EncodingCXX.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/EncodingCXX.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/EncodingCXX.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_ENCODING_DEFAULT_CODEPAGE=CP_UTF8 $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/EncodingCXX.cxx -o CMakeFiles/cmsys.dir/EncodingCXX.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/Glob.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/Glob.cxx.o: Source/kwsys/Glob.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/Glob.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/Glob.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/Glob.cxx

Source/kwsys/CMakeFiles/cmsys.dir/Glob.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/Glob.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/Glob.cxx > CMakeFiles/cmsys.dir/Glob.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/Glob.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/Glob.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/Glob.cxx -o CMakeFiles/cmsys.dir/Glob.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/RegularExpression.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/RegularExpression.cxx.o: Source/kwsys/RegularExpression.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/RegularExpression.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/RegularExpression.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/RegularExpression.cxx

Source/kwsys/CMakeFiles/cmsys.dir/RegularExpression.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/RegularExpression.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/RegularExpression.cxx > CMakeFiles/cmsys.dir/RegularExpression.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/RegularExpression.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/RegularExpression.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/RegularExpression.cxx -o CMakeFiles/cmsys.dir/RegularExpression.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/SystemTools.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/SystemTools.cxx.o: Source/kwsys/SystemTools.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/SystemTools.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) -DKWSYS_CXX_HAS_ENVIRON_IN_STDLIB_H=0 -DKWSYS_CXX_HAS_SETENV=1 -DKWSYS_CXX_HAS_UNSETENV=1 -DKWSYS_CXX_HAS_UTIMENSAT=1 -DKWSYS_CXX_HAS_UTIMES=1 -DKWSYS_CXX_STAT_HAS_ST_MTIM=1 -DKWSYS_CXX_STAT_HAS_ST_MTIMESPEC=0 $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/SystemTools.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/SystemTools.cxx

Source/kwsys/CMakeFiles/cmsys.dir/SystemTools.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/SystemTools.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_CXX_HAS_ENVIRON_IN_STDLIB_H=0 -DKWSYS_CXX_HAS_SETENV=1 -DKWSYS_CXX_HAS_UNSETENV=1 -DKWSYS_CXX_HAS_UTIMENSAT=1 -DKWSYS_CXX_HAS_UTIMES=1 -DKWSYS_CXX_STAT_HAS_ST_MTIM=1 -DKWSYS_CXX_STAT_HAS_ST_MTIMESPEC=0 $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/SystemTools.cxx > CMakeFiles/cmsys.dir/SystemTools.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/SystemTools.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/SystemTools.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_CXX_HAS_ENVIRON_IN_STDLIB_H=0 -DKWSYS_CXX_HAS_SETENV=1 -DKWSYS_CXX_HAS_UNSETENV=1 -DKWSYS_CXX_HAS_UTIMENSAT=1 -DKWSYS_CXX_HAS_UTIMES=1 -DKWSYS_CXX_STAT_HAS_ST_MTIM=1 -DKWSYS_CXX_STAT_HAS_ST_MTIMESPEC=0 $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/SystemTools.cxx -o CMakeFiles/cmsys.dir/SystemTools.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/CommandLineArguments.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/CommandLineArguments.cxx.o: Source/kwsys/CommandLineArguments.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_14) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/CommandLineArguments.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/CommandLineArguments.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/CommandLineArguments.cxx

Source/kwsys/CMakeFiles/cmsys.dir/CommandLineArguments.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/CommandLineArguments.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/CommandLineArguments.cxx > CMakeFiles/cmsys.dir/CommandLineArguments.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/CommandLineArguments.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/CommandLineArguments.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/CommandLineArguments.cxx -o CMakeFiles/cmsys.dir/CommandLineArguments.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/IOStream.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/IOStream.cxx.o: Source/kwsys/IOStream.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_15) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/IOStream.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/IOStream.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/IOStream.cxx

Source/kwsys/CMakeFiles/cmsys.dir/IOStream.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/IOStream.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/IOStream.cxx > CMakeFiles/cmsys.dir/IOStream.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/IOStream.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/IOStream.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/IOStream.cxx -o CMakeFiles/cmsys.dir/IOStream.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/FStream.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/FStream.cxx.o: Source/kwsys/FStream.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_16) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/FStream.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/FStream.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/FStream.cxx

Source/kwsys/CMakeFiles/cmsys.dir/FStream.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/FStream.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/FStream.cxx > CMakeFiles/cmsys.dir/FStream.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/FStream.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/FStream.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/FStream.cxx -o CMakeFiles/cmsys.dir/FStream.cxx.s

Source/kwsys/CMakeFiles/cmsys.dir/SystemInformation.cxx.o: Source/kwsys/CMakeFiles/cmsys.dir/flags.make
Source/kwsys/CMakeFiles/cmsys.dir/SystemInformation.cxx.o: Source/kwsys/SystemInformation.cxx
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_17) "Building CXX object Source/kwsys/CMakeFiles/cmsys.dir/SystemInformation.cxx.o"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++  $(CXX_DEFINES) -DKWSYS_CXX_HAS_ATOL=1 -DKWSYS_CXX_HAS_ATOLL=1 -DKWSYS_CXX_HAS_GETLOADAVG=1 -DKWSYS_CXX_HAS_RLIMIT64=1 -DKWSYS_IOS_HAS_OSTREAM_LONG_LONG=1 -DKWSYS_SYSTEMINFORMATION_HAS_BACKTRACE=1 -DKWSYS_SYSTEMINFORMATION_HAS_CPP_DEMANGLE=1 -DKWSYS_SYSTEMINFORMATION_HAS_SYMBOL_LOOKUP=1 -DKWSYS_SYS_HAS_IFADDRS_H=1 -DKWSYS_USE_LONG_LONG=1 -DSIZEOF_VOID_P=8 $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/cmsys.dir/SystemInformation.cxx.o -c /apollo/voxnet/cmake-3.13.4/Source/kwsys/SystemInformation.cxx

Source/kwsys/CMakeFiles/cmsys.dir/SystemInformation.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/cmsys.dir/SystemInformation.cxx.i"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_CXX_HAS_ATOL=1 -DKWSYS_CXX_HAS_ATOLL=1 -DKWSYS_CXX_HAS_GETLOADAVG=1 -DKWSYS_CXX_HAS_RLIMIT64=1 -DKWSYS_IOS_HAS_OSTREAM_LONG_LONG=1 -DKWSYS_SYSTEMINFORMATION_HAS_BACKTRACE=1 -DKWSYS_SYSTEMINFORMATION_HAS_CPP_DEMANGLE=1 -DKWSYS_SYSTEMINFORMATION_HAS_SYMBOL_LOOKUP=1 -DKWSYS_SYS_HAS_IFADDRS_H=1 -DKWSYS_USE_LONG_LONG=1 -DSIZEOF_VOID_P=8 $(CXX_INCLUDES) $(CXX_FLAGS) -E /apollo/voxnet/cmake-3.13.4/Source/kwsys/SystemInformation.cxx > CMakeFiles/cmsys.dir/SystemInformation.cxx.i

Source/kwsys/CMakeFiles/cmsys.dir/SystemInformation.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/cmsys.dir/SystemInformation.cxx.s"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && /usr/bin/g++ $(CXX_DEFINES) -DKWSYS_CXX_HAS_ATOL=1 -DKWSYS_CXX_HAS_ATOLL=1 -DKWSYS_CXX_HAS_GETLOADAVG=1 -DKWSYS_CXX_HAS_RLIMIT64=1 -DKWSYS_IOS_HAS_OSTREAM_LONG_LONG=1 -DKWSYS_SYSTEMINFORMATION_HAS_BACKTRACE=1 -DKWSYS_SYSTEMINFORMATION_HAS_CPP_DEMANGLE=1 -DKWSYS_SYSTEMINFORMATION_HAS_SYMBOL_LOOKUP=1 -DKWSYS_SYS_HAS_IFADDRS_H=1 -DKWSYS_USE_LONG_LONG=1 -DSIZEOF_VOID_P=8 $(CXX_INCLUDES) $(CXX_FLAGS) -S /apollo/voxnet/cmake-3.13.4/Source/kwsys/SystemInformation.cxx -o CMakeFiles/cmsys.dir/SystemInformation.cxx.s

# Object files for target cmsys
cmsys_OBJECTS = \
"CMakeFiles/cmsys.dir/ProcessUNIX.c.o" \
"CMakeFiles/cmsys.dir/Base64.c.o" \
"CMakeFiles/cmsys.dir/EncodingC.c.o" \
"CMakeFiles/cmsys.dir/MD5.c.o" \
"CMakeFiles/cmsys.dir/Terminal.c.o" \
"CMakeFiles/cmsys.dir/System.c.o" \
"CMakeFiles/cmsys.dir/String.c.o" \
"CMakeFiles/cmsys.dir/Directory.cxx.o" \
"CMakeFiles/cmsys.dir/DynamicLoader.cxx.o" \
"CMakeFiles/cmsys.dir/EncodingCXX.cxx.o" \
"CMakeFiles/cmsys.dir/Glob.cxx.o" \
"CMakeFiles/cmsys.dir/RegularExpression.cxx.o" \
"CMakeFiles/cmsys.dir/SystemTools.cxx.o" \
"CMakeFiles/cmsys.dir/CommandLineArguments.cxx.o" \
"CMakeFiles/cmsys.dir/IOStream.cxx.o" \
"CMakeFiles/cmsys.dir/FStream.cxx.o" \
"CMakeFiles/cmsys.dir/SystemInformation.cxx.o"

# External object files for target cmsys
cmsys_EXTERNAL_OBJECTS =

Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/ProcessUNIX.c.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/Base64.c.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/EncodingC.c.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/MD5.c.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/Terminal.c.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/System.c.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/String.c.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/Directory.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/DynamicLoader.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/EncodingCXX.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/Glob.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/RegularExpression.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/SystemTools.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/CommandLineArguments.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/IOStream.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/FStream.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/SystemInformation.cxx.o
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/build.make
Source/kwsys/libcmsys.a: Source/kwsys/CMakeFiles/cmsys.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/apollo/voxnet/cmake-3.13.4/CMakeFiles --progress-num=$(CMAKE_PROGRESS_18) "Linking CXX static library libcmsys.a"
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && $(CMAKE_COMMAND) -P CMakeFiles/cmsys.dir/cmake_clean_target.cmake
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/cmsys.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
Source/kwsys/CMakeFiles/cmsys.dir/build: Source/kwsys/libcmsys.a

.PHONY : Source/kwsys/CMakeFiles/cmsys.dir/build

Source/kwsys/CMakeFiles/cmsys.dir/clean:
	cd /apollo/voxnet/cmake-3.13.4/Source/kwsys && $(CMAKE_COMMAND) -P CMakeFiles/cmsys.dir/cmake_clean.cmake
.PHONY : Source/kwsys/CMakeFiles/cmsys.dir/clean

Source/kwsys/CMakeFiles/cmsys.dir/depend:
	cd /apollo/voxnet/cmake-3.13.4 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /apollo/voxnet/cmake-3.13.4 /apollo/voxnet/cmake-3.13.4/Source/kwsys /apollo/voxnet/cmake-3.13.4 /apollo/voxnet/cmake-3.13.4/Source/kwsys /apollo/voxnet/cmake-3.13.4/Source/kwsys/CMakeFiles/cmsys.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : Source/kwsys/CMakeFiles/cmsys.dir/depend

