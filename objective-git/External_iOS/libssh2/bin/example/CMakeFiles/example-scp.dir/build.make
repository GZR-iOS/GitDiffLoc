# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

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
CMAKE_COMMAND = /opt/local/bin/cmake

# The command to remove a file.
RM = /opt/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin

# Include any dependencies generated for this target.
include example/CMakeFiles/example-scp.dir/depend.make

# Include the progress variables for this target.
include example/CMakeFiles/example-scp.dir/progress.make

# Include the compile flags for this target's objects.
include example/CMakeFiles/example-scp.dir/flags.make

example/CMakeFiles/example-scp.dir/scp.c.o: example/CMakeFiles/example-scp.dir/flags.make
example/CMakeFiles/example-scp.dir/scp.c.o: ../example/scp.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object example/CMakeFiles/example-scp.dir/scp.c.o"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/example-scp.dir/scp.c.o   -c /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example/scp.c

example/CMakeFiles/example-scp.dir/scp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/example-scp.dir/scp.c.i"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example/scp.c > CMakeFiles/example-scp.dir/scp.c.i

example/CMakeFiles/example-scp.dir/scp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/example-scp.dir/scp.c.s"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example/scp.c -o CMakeFiles/example-scp.dir/scp.c.s

# Object files for target example-scp
example__scp_OBJECTS = \
"CMakeFiles/example-scp.dir/scp.c.o"

# External object files for target example-scp
example__scp_EXTERNAL_OBJECTS =

example/example-scp: example/CMakeFiles/example-scp.dir/scp.c.o
example/example-scp: example/CMakeFiles/example-scp.dir/build.make
example/example-scp: src/libssh2.a
example/example-scp: /opt/local/lib/libssl.dylib
example/example-scp: /opt/local/lib/libcrypto.dylib
example/example-scp: example/CMakeFiles/example-scp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable example-scp"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/example-scp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
example/CMakeFiles/example-scp.dir/build: example/example-scp

.PHONY : example/CMakeFiles/example-scp.dir/build

example/CMakeFiles/example-scp.dir/clean:
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && $(CMAKE_COMMAND) -P CMakeFiles/example-scp.dir/cmake_clean.cmake
.PHONY : example/CMakeFiles/example-scp.dir/clean

example/CMakeFiles/example-scp.dir/depend:
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2 /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example/CMakeFiles/example-scp.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : example/CMakeFiles/example-scp.dir/depend

