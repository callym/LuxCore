include(FetchContent)

set(EXPAT_BUILD_EXAMPLES OFF)
set(EXPAT_BUILD_FUZZERS OFF)
set(EXPAT_BUILD_TESTS OFF)
set(EXPAT_BUILD_TOOLS OFF)
set(EXPAT_BUILD_PKGCONFIG OFF)

set(EXPAT_ENABLE_INSTALL OFF)

FetchContent_Declare(
    expat
    GIT_REPOSITORY https://github.com/libexpat/libexpat.git
    GIT_TAG R_2_5_0
    GIT_PROGRESS TRUE
    GIT_SHALLOW 1
    SOURCE_SUBDIR expat
)

FetchContent_MakeAvailable(expat)

add_library(expat::expat ALIAS expat)