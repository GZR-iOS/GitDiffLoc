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
include example/CMakeFiles/example-sftp_append.dir/depend.make

# Include the progress variables for this target.
include example/CMakeFiles/example-sftp_append.dir/progress.make

# Include the compile flags for this target's objects.
include example/CMakeFiles/example-sftp_append.dir/flags.make

example/CMakeFiles/example-sftp_append.dir/sftp_append.c.o: example/CMakeFiles/example-sftp_append.dir/flags.make
example/CMakeFiles/example-sftp_append.dir/sftp_append.c.o: ../example/sftp_append.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object example/CMakeFiles/example-sftp_append.dir/sftp_append.c.o"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/example-sftp_append.dir/sftp_append.c.o   -c /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example/sftp_append.c

example/CMakeFiles/example-sftp_append.dir/sftp_append.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/example-sftp_append.dir/sftp_append.c.i"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example/sftp_append.c > CMakeFiles/example-sftp_append.dir/sftp_append.c.i

example/CMakeFiles/example-sftp_append.dir/sftp_append.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/example-sftp_append.dir/sftp_append.c.s"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example/sftp_append.c -o CMakeFiles/example-sftp_append.dir/sftp_append.c.s

# Object files for target example-sftp_append
example__sftp_append_OBJECTS = \
"CMakeFiles/example-sftp_append.dir/sftp_append.c.o"

# External object files for target example-sftp_append
example__sftp_append_EXTERNAL_OBJECTS =

example/example-sftp_append: example/CMakeFiles/example-sftp_append.dir/sftp_append.c.o
example/example-sftp_append: example/CMakeFiles/example-sftp_append.dir/build.make
example/example-sftp_append: src/libssh2.a
example/example-sftp_append: /opt/local/lib/libssl.dylib
example/example-sftp_append: /opt/local/lib/libcrypto.dylib
example/example-sftp_append: example/CMakeFiles/example-sftp_append.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable example-sftp_append"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/example-sftp_append.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
example/CMakeFiles/example-sftp_append.dir/build: example/example-sftp_append

.PHONY : example/CMakeFiles/example-sftp_append.dir/build

example/CMakeFiles/example-sftp_append.dir/clean:
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example && $(CMAKE_COMMAND) -P CMakeFiles/example-sftp_append.dir/cmake_clean.cmake
.PHONY : example/CMakeFiles/example-sftp_append.dir/clean

example/CMakeFiles/example-sftp_append.dir/depend:
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2 /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/example /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/example/CMakeFiles/example-sftp_append.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : example/CMakeFiles/example-sftp_append.dir/depend

