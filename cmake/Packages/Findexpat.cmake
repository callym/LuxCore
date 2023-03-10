include(FetchContent)

FetchContent_Declare(
    expat
    GIT_REPOSITORY https://github.com/libexpat/libexpat.git
    GIT_TAG R_2_5_0
    GIT_PROGRESS TRUE
    GIT_SHALLOW 1
    SOURCE_SUBDIR expat
)

FetchContent_MakeAvailable(expat)