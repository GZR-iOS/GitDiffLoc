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
include tests/CMakeFiles/runner.dir/depend.make

# Include the progress variables for this target.
include tests/CMakeFiles/runner.dir/progress.make

# Include the compile flags for this target's objects.
include tests/CMakeFiles/runner.dir/flags.make

tests/CMakeFiles/runner.dir/runner.c.o: tests/CMakeFiles/runner.dir/flags.make
tests/CMakeFiles/runner.dir/runner.c.o: ../tests/runner.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object tests/CMakeFiles/runner.dir/runner.c.o"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/runner.dir/runner.c.o   -c /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/runner.c

tests/CMakeFiles/runner.dir/runner.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/runner.dir/runner.c.i"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/runner.c > CMakeFiles/runner.dir/runner.c.i

tests/CMakeFiles/runner.dir/runner.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/runner.dir/runner.c.s"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/runner.c -o CMakeFiles/runner.dir/runner.c.s

# Object files for target runner
runner_OBJECTS = \
"CMakeFiles/runner.dir/runner.c.o"

# External object files for target runner
runner_EXTERNAL_OBJECTS =

tests/librunner.a: tests/CMakeFiles/runner.dir/runner.c.o
tests/librunner.a: tests/CMakeFiles/runner.dir/build.make
tests/librunner.a: tests/CMakeFiles/runner.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library librunner.a"
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests && $(CMAKE_COMMAND) -P CMakeFiles/runner.dir/cmake_clean_target.cmake
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/runner.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tests/CMakeFiles/runner.dir/build: tests/librunner.a

.PHONY : tests/CMakeFiles/runner.dir/build

tests/CMakeFiles/runner.dir/clean:
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests && $(CMAKE_COMMAND) -P CMakeFiles/runner.dir/cmake_clean.cmake
.PHONY : tests/CMakeFiles/runner.dir/clean

tests/CMakeFiles/runner.dir/depend:
	cd /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2 /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/CMakeFiles/runner.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tests/CMakeFiles/runner.dir/depend

