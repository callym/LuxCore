include(FetchContent)

FetchContent_Declare(
    Optix
    URL https://developer.download.nvidia.com/redist/optix/v7.6/OptiX-7.6-Include.zip
    URL_HASH MD5=32f170454a9a6c944854ca6fef8c5ec1
)

FetchContent_MakeAvailable(Optix)

set(OPTIX_INCLUDE_PATH ${optix_SOURCE_DIR})