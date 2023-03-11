# ###############################################################################
# Copyright 1998-2020 by authors (see AUTHORS.txt)
#
# This file is part of LuxCoreRender.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ###############################################################################

include(FindPkgMacros)
getenv_path(LuxRays_DEPENDENCIES_DIR)

set(FETCHCONTENT_QUIET FALSE CACHE BOOL FALSE FORCE)

# ###############################################################################
#
# Core dependencies
#
# ###############################################################################
include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}/include
    ${CMAKE_CURRENT_BINARY_DIR}/include/OpenColorIO
    ${CMAKE_CURRENT_BINARY_DIR}/include/OpenImageIO
)

# Find Boost
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_MINIMUM_VERSION "1.56.0")

# For Windows builds, PYTHON_V must be defined as "3x" (x=Python minor version, e.g. "35")
# For other platforms, specifying python minor version is not needed
set(LUXRAYS_BOOST_COMPONENTS thread program_options filesystem serialization iostreams regex system python${PYTHON_V} chrono serialization numpy${PYTHON_V})
find_package(Boost REQUIRED COMPONENTS ${LUXRAYS_BOOST_COMPONENTS})

include_directories(${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})

# Don't use old boost versions interfaces
ADD_DEFINITIONS(-DBOOST_FILESYSTEM_NO_DEPRECATED)

if(Boost_USE_STATIC_LIBS)
    ADD_DEFINITIONS(-DBOOST_STATIC_LIB)
    ADD_DEFINITIONS(-DBOOST_PYTHON_STATIC_LIB)
endif()

# Find threading library
find_package(Threads REQUIRED)

find_package(fmt REQUIRED)
set(FMT_INCLUDES ${fmt_SOURCE_DIR}/include)
include_directories(
    ${FMT_INCLUDES}
)

find_package(spdlog REQUIRED)
include_directories(
    ${spdlog_SOURCE_DIR}/include
)

find_package(Imath REQUIRED)
include_directories(
    ${imath_SOURCE_DIR}/src
    ${imath_SOURCE_DIR}/src/Imath
    ${imath_BINARY_DIR}/config
)

find_package(OpenEXR REQUIRED)

function(subproject_version subproject_name VERSION_VAR)
    # Read CMakeLists.txt for subproject and extract project() call(s) from it.
    file(STRINGS "${${subproject_name}_SOURCE_DIR}/CMakeLists.txt" project_calls REGEX "[ \t]*project\\(")

    # For every project() call try to extract its VERSION option
    foreach(project_call ${project_calls})
        string(REGEX MATCH "VERSION[ ]+([^ )]+)" version_param "${project_call}")

        if(version_param)
            set(version_value "${CMAKE_MATCH_1}")
        endif()
    endforeach()

    if(version_value)
        set(${VERSION_VAR} "${version_value}" PARENT_SCOPE)
    else()
        message("WARNING: Cannot extract version for subproject '${subproject_name}'")
    endif()
endfunction(subproject_version)

subproject_version(openexr OpenEXR_VERSION)

set(OpenEXR_VERSION "${OpenEXR_VERSION}")
set(OPENEXR_VERSION "${OpenEXR_VERSION}")

include_directories(
    ${openexr_SOURCE_DIR}/src/lib
    ${openexr_SOURCE_DIR}/src/lib/OpenEXR
    ${openexr_SOURCE_DIR}/src/lib/Iex
    ${openexr_BINARY_DIR}/cmake
)

find_package(expat REQUIRED)
add_library(expat::expat ALIAS expat)

find_package(yaml-cpp REQUIRED)

find_package(pystring REQUIRED)
add_library(
    pystringstatic
    STATIC
    ${pystring_SOURCE_DIR}/pystring.cpp
    ${pystring_SOURCE_DIR}/pystring.h
)
add_library(pystring::pystring ALIAS pystringstatic)

find_package(minizip-ng REQUIRED)
add_library(MINIZIP::minizip-ng ALIAS minizip)

find_package(OpenColorIO REQUIRED)
include_directories(${opencolorio_BINARY_DIR}/src)
include_directories(${opencolorio_SOURCE_DIR}/include)

find_package(OpenColorIO-Configs REQUIRED)

include_directories(
    ${FETCHCONTENT_BASE_DIR}/openimageio-src/src/include
    ${FETCHCONTENT_BASE_DIR}/openimageio-src/src/include/OpenImageIO
)
find_package(OpenImageIO REQUIRED)
add_library(OpenImageIO_v2_4 ALIAS OpenImageIO)

find_package(bcd REQUIRED)
include_directories(${bcd_SOURCE_DIR}/include)

find_package(json REQUIRED)
include_directories(${json_SOURCE_DIR}/include)

find_package(CUEW REQUIRED)
include_directories(${cuew_SOURCE_DIR}/include)

find_package(CLEW REQUIRED)
set(CLEW_INCLUDE_DIR ${clew_SOURCE_DIR}/include)
include_directories(${CLEW_INCLUDE_DIR})

find_package(LUT REQUIRED)
include_directories(${lut_SOURCE_DIR})

if(NOT APPLE)
    # Apple has these available hardcoded and matched in macos repo, see Config_OSX.cmake
    include_directories(${OPENEXR_INCLUDE_DIRS})
    find_package(TIFF REQUIRED)
    include_directories(${TIFF_INCLUDE_DIR})
    find_package(JPEG REQUIRED)
    include_directories(${JPEG_INCLUDE_DIR})
    find_package(PNG REQUIRED)
    include_directories(${PNG_PNG_INCLUDE_DIR})

    find_package(Python3 COMPONENTS Development)

    include_directories(${Python3_INCLUDE_DIRS})
    link_directories(${Python3_LIBRARY_DIRS})
    link_libraries(${Python3_LIBRARIES})
endif()

find_program(PYSIDE_UIC NAMES pyside-uic pyside2-uic pyside6-uic
    HINTS "${PYTHON_INCLUDE_DIRS}/../Scripts"
    PATHS "c:/Program Files/Python${PYTHON_V}/Scripts")

include_directories(${PYTHON_INCLUDE_DIRS})

find_package(OpenGL)

if(OPENGL_FOUND)
    include_directories(${OPENGL_INCLUDE_PATH})
endif()

find_package(Oidn REQUIRED)
include_directories(${OIDN_INCLUDE_PATH})
set(OIDN_LIBRARY OpenImageDenoise)

find_package(Embree REQUIRED)
include_directories(${EMBREE_INCLUDE_PATH})
set(EMBREE_LIBRARY embree)

find_package(Blosc REQUIRED)
include_directories(${BLOSC_INCLUDE_PATH})
set(BLOSC_LIBRARY blosc_static)

find_package(opensubdiv REQUIRED)
include_directories(${opensubdiv_SOURCE_DIR})
set(OSD_LINK_TARGET osd_static_gpu osd_static_cpu)

# OpenMP
if(NOT APPLE)
    find_package(OpenMP)

    if(OPENMP_FOUND)
        MESSAGE(STATUS "OpenMP found - compiling with")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
    else()
        MESSAGE(WARNING "OpenMP not found - compiling without")
    endif()
endif()

# Find GTK 3.0 for Linux only (required by luxcoreui NFD)
if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
    include_directories(${GTK3_INCLUDE_DIRS})
endif()

# Find BISON
IF(NOT BISON_NOT_AVAILABLE)
    find_package(BISON)
ENDIF(NOT BISON_NOT_AVAILABLE)

# Find FLEX
IF(NOT FLEX_NOT_AVAILABLE)
    find_package(FLEX)
ENDIF(NOT FLEX_NOT_AVAILABLE)
