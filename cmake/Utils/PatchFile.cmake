# https://github.com/scivision/cmake-patch-file/blob/main/cmake/PatchFile.cmake
# use GNU Patch from any platform

if(WIN32)
    # prioritize Git Patch on Windows as other Patches may be very old and incompatible.
    find_package(Git)

    if(Git_FOUND)
        get_filename_component(GIT_DIR ${GIT_EXECUTABLE} DIRECTORY)
        get_filename_component(GIT_DIR ${GIT_DIR} DIRECTORY)
    endif()
endif()

find_program(PATCH
    NAMES patch
    HINTS ${GIT_DIR}
    PATH_SUFFIXES usr/bin
)

if(NOT PATCH)
    message(FATAL_ERROR "Did not find GNU Patch")
endif()

execute_process(COMMAND ${PATCH} --dry-run -R -sf ${in_file} ${patch_file}
    TIMEOUT 15
    COMMAND_ECHO STDOUT
    RESULT_VARIABLE ret
)

if(ret EQUAL 0)
    message(STATUS "Patch already applied")
else()
    message(STATUS "Patch not applied, patching now...")

    execute_process(COMMAND ${PATCH} ${in_file} ${patch_file}
        TIMEOUT 15
        COMMAND_ECHO STDOUT
        RESULT_VARIABLE ret
    )

    if(NOT ret EQUAL 0)
        message(FATAL_ERROR "Failed to apply patch ${patch_file} to ${in_file} with ${PATCH}")
    endif()
endif()