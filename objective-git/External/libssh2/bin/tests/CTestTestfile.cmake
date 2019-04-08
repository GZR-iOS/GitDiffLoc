# CMake generated Testfile for 
# Source directory: /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests
# Build directory: /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_hostkey "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_hostkey")
set_tests_properties(test_hostkey PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_hostkey_hash "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_hostkey_hash")
set_tests_properties(test_hostkey_hash PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_password_auth_succeeds_with_correct_credentials "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_password_auth_succeeds_with_correct_credentials")
set_tests_properties(test_password_auth_succeeds_with_correct_credentials PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_password_auth_fails_with_wrong_password "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_password_auth_fails_with_wrong_password")
set_tests_properties(test_password_auth_fails_with_wrong_password PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_password_auth_fails_with_wrong_username "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_password_auth_fails_with_wrong_username")
set_tests_properties(test_password_auth_fails_with_wrong_username PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_public_key_auth_fails_with_wrong_key "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_public_key_auth_fails_with_wrong_key")
set_tests_properties(test_public_key_auth_fails_with_wrong_key PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_public_key_auth_succeeds_with_correct_rsa_key "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_public_key_auth_succeeds_with_correct_rsa_key")
set_tests_properties(test_public_key_auth_succeeds_with_correct_rsa_key PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_public_key_auth_succeeds_with_correct_dsa_key "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_public_key_auth_succeeds_with_correct_dsa_key")
set_tests_properties(test_public_key_auth_succeeds_with_correct_dsa_key PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_keyboard_interactive_auth_fails_with_wrong_response "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_keyboard_interactive_auth_fails_with_wrong_response")
set_tests_properties(test_keyboard_interactive_auth_fails_with_wrong_response PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(test_keyboard_interactive_auth_succeeds_with_correct_response "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/bin/tests/test_keyboard_interactive_auth_succeeds_with_correct_response")
set_tests_properties(test_keyboard_interactive_auth_succeeds_with_correct_response PROPERTIES  WORKING_DIRECTORY "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests" _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;86;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
add_test(mansyntax "/bin/sh" "-c" "srcdir=/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests /Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/mansyntax.sh")
set_tests_properties(mansyntax PROPERTIES  _BACKTRACE_TRIPLES "/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;107;add_test;/Users/soleilpqd/PROJECTS/GitDiff/objective-git/External/libssh2/tests/CMakeLists.txt;0;")
