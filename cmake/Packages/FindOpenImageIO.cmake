include(FetchContent)

set(ENABLE_BZIP2 OFF)
set(ENABLE_FREETYPE OFF)
set(ENABLE_FFMPEG OFF)
set(ENABLE_OPENCV OFF)

set(OIIO_BUILD_TESTS OFF)
set(OIIO_BUILD_TOOLS OFF)

set(BUILD_SHARED_LIBS OFF)

FetchContent_Declare(
  OpenImageIO
  GIT_REPOSITORY "https://github.com/OpenImageIO/oiio.git"
  GIT_TAG v2.4.9.0
  GIT_PROGRESS TRUE
  GIT_SHALLOW 1
  OVERRIDE_FIND_PACKAGE

  PATCH_COMMAND
  ${CMAKE_COMMAND}
  -Din_file:FILEPATH=${FETCHCONTENT_BASE_DIR}/openimageio-src/CMakeLists.txt
  -Dpatch_file:FILEPATH=${CMAKE_CURRENT_SOURCE_DIR}/cmake/Packages/patches/openimageio-src/CMakeLists.patch
  -Dout_file:FILEPATH=${FETCHCONTENT_BASE_DIR}/openimageio-src/CMakeLists.txt
  -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Utils/PatchFile.cmake
)

FetchContent_GetProperties(OpenImageIO)

if(NOT openimageio_POPULATED)
  FetchContent_Populate(OpenImageIO)
  add_subdirectory(${openimageio_SOURCE_DIR} ${openimageio_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

set_target_properties(OpenImageIO PROPERTIES EXCLUDE_FROM_ALL TRUE)

add_custom_command(
  OUTPUT ${openimageio_SOURCE_DIR}/CMakeLists.txt
  COMMAND ${CMAKE_COMMAND}
  -Din_file:FILEPATH=${openimageio_SOURCE_DIR}/CMakeLists.txt
  -Dpatch_file:FILEPATH=${CMAKE_CURRENT_SOURCE_DIR}/cmake/Packages/patches/openimageio-src/CMakeLists.patch
  -Dout_file:FILEPATH=${openimageio_SOURCE_DIR}/CMakeLists.txt
  -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Utils/PatchFile.cmake
  DEPENDS ${openimageio_SOURCE_DIR}/CMakeLists.txt
)

set(OPENIMAGEIO_FOUND ON)

target_compile_definitions(OpenImageIO PRIVATE OIIO_USING_IMATH=3)
target_compile_definitions(OpenImageIO_Util PRIVATE OIIO_USING_IMATH=3)

set(OPENIMAGEIO_INCLUDES
  ${CMAKE_CURRENT_BINARY_DIR}/include/OpenImageIO
)