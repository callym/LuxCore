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

set(FETCHCONTENT_QUIET FALSE CACHE BOOL FALSE FORCE)

# ###############################################################################
#
# Core dependencies
#
# ###############################################################################
include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}/include
)

# Find Boost
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)
set(Boost_MINIMUM_VERSION "1.56.0")

# For Windows builds, PYTHON_V must be defined as "3x" (x=Python minor version, e.g. "35")
# For other platforms, specifying python minor version is not needed
set(LUXRAYS_BOOST_COMPONENTS
    thread
    program_options
    filesystem
    serialization
    iostreams
    regex
    system
    chrono
    python${PYTHON_V}
    numpy${PYTHON_V}
)
find_package(Boost REQUIRED COMPONENTS ${LUXRAYS_BOOST_COMPONENTS})

include_directories(${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIRS})

# Don't use old boost versions interfaces
ADD_DEFINITIONS(-DBOOST_FILESYSTEM_NO_DEPRECATED)

if(Boost_USE_STATIC_LIBS)
    ADD_DEFINITIONS(-DBOOST_STATIC_LIB)
    ADD_DEFINITIONS(-DBOOST_PYTHON_STATIC_LIB)
endif()

# Some dependencies (OpenVDB!) overwrite `Boost_LIBRARIES`
# so we're saving it here and will merge them after that
SET(Boost_Save ${Boost_LIBRARIES})

# Find threading library
find_package(Threads REQUIRED)

find_package(fmt REQUIRED)
include_directories(${FMT_INCLUDES})

find_package(spdlog REQUIRED)
include_directories(${SPDLOG_INCLUDES})

find_package(Imath REQUIRED)
include_directories(${IMATH_INCLUDES})

find_package(OpenEXR REQUIRED)
include_directories(${OPENEXR_INCLUDES})

find_package(expat REQUIRED)

find_package(yaml-cpp REQUIRED)

find_package(pystring REQUIRED)

find_package(minizip-ng REQUIRED)

find_package(OpenColorIO REQUIRED)
include_directories(${OPENCOLORIO_INCLUDES})

find_package(OpenColorIO-Configs REQUIRED)

find_package(Blosc REQUIRED)
include_directories(${BLOSC_INCLUDES})

find_package(OpenVDB REQUIRED)

find_package(OpenImageIO REQUIRED)
include_directories(${OPENIMAGEIO_INCLUDES})

find_package(bcd REQUIRED)
include_directories(${BCD_INCLUDES})

find_package(json REQUIRED)
include_directories(${JSON_INCLUDES})

find_package(CUEW REQUIRED)
include_directories(${CUEW_INCLUDES})

find_package(CLEW REQUIRED)
include_directories(${CLEW_INCLUDES})

find_package(LUT REQUIRED)
include_directories(${LUT_INCLUDES})

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

find_program(PYSIDE_UIC NAMES pyside-uic pyside2-uic pyside6-uic
    HINTS "${PYTHON_INCLUDE_DIRS}/../Scripts"
    PATHS "c:/Program Files/Python${PYTHON_V}/Scripts")

find_package(OpenGL)

if(OPENGL_FOUND)
    include_directories(${OPENGL_INCLUDE_PATH})
endif()

find_package(Oidn REQUIRED)
include_directories(${OIDN_INCLUDE_PATH})

find_package(Embree REQUIRED)
include_directories(${EMBREE_INCLUDE_PATH})

find_package(opensubdiv REQUIRED)
include_directories(${OPENSUBDIV_INCLUDE_PATH})

find_package(robin-hood-hashing REQUIRED)
include_directories(${ROBIN_HOOD_HASHING_INCLUDE_PATH})

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

LIST(APPEND Boost_LIBRARIES ${Boost_Save})
