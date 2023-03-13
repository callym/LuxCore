git(OpenEXR AcademySoftwareFoundation/openexr v3.1.6)

set(OpenEXR_FOUND ON)

set(BUILD_TESTING OFF)
set(OPENEXR_INSTALL ON)
set(BUILD_SHARED_LIBS OFF)

set(OpenEXR_VERSION 3.1.6)
set(OPENEXR_VERSION "${OpenEXR_VERSION}")

set(OPENEXR_INCLUDES
    ${openexr_SOURCE_DIR}/src/lib
    ${openexr_SOURCE_DIR}/src/lib/OpenEXR
    ${openexr_SOURCE_DIR}/src/lib/Iex
    ${openexr_BINARY_DIR}/cmake
)