set(BUILD_SHARED OFF)
set(BUILD_TESTS OFF)
set(BUILD_FUZZERS OFF)
set(BUILD_BENCHMARKS OFF)

git(Blosc Blosc/c-blosc v1.21.2)

set(BLOSC_FOUND TRUE)
set(BLOSC_LIBRARY blosc_static)

add_library(Blosc::blosc ALIAS blosc_static)

set(BLOSC_INCLUDES ${BLOSC_INCLUDE_PATH})