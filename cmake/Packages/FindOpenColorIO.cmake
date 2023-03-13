set(OCIO_BUILD_APPS OFF)
set(OCIO_BUILD_TESTS OFF)
set(OCIO_BUILD_GPU_TESTS OFF)
set(OCIO_BUILD_PYTHON OFF)
set(OCIO_INSTALL OFF)

git(OpenColorIO callym/OpenColorIO main)

set(BUILD_SHARED_LIBS OFF)

set(OPENCOLORIO_INCLUDES
    ${opencolorio_BINARY_DIR}/src
    ${opencolorio_SOURCE_DIR}/include
    ${CMAKE_CURRENT_BINARY_DIR}/include/OpenColorIO
)