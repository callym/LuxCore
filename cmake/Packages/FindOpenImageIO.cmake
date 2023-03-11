include(FetchContent)

set(ENABLE_BZIP2 OFF)
set(ENABLE_FREETYPE OFF)
set(ENABLE_FFMPEG OFF)
set(ENABLE_OPENCV OFF)

git_declare(OpenImageIO OpenImageIO/oiio v2.4.9.0)

FetchContent_GetProperties(OpenImageIO)

if(NOT openimageio_POPULATED)
  FetchContent_Populate(OpenImageIO)
  add_subdirectory(${openimageio_SOURCE_DIR} ${openimageio_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

set_target_properties(OpenImageIO PROPERTIES EXCLUDE_FROM_ALL TRUE)

set(OPENIMAGEIO_FOUND ON)

target_compile_definitions(OpenImageIO PRIVATE OIIO_USING_IMATH=3)
target_compile_definitions(OpenImageIO_Util PRIVATE OIIO_USING_IMATH=3)

set(OIIO_BUILD_TESTS OFF)
set(OIIO_BUILD_TOOLS OFF)

set(BUILD_SHARED_LIBS OFF)