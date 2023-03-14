include(FetchContent)

FetchContent_Declare(
    Optix

    # URL https://developer.download.nvidia.com/redist/optix/v7.0/OptiX-7.0.0-include.zip
    # URL https://developer.download.nvidia.com/redist/optix/v7.1/OptiX-7.1.0-include.zip
    URL https://developer.download.nvidia.com/redist/optix/v7.3/OptiX-7.3.0-Include.zip

    # URL https://developer.download.nvidia.com/redist/optix/v7.5/OptiX-7.5-Include.zip
    # URL https://developer.download.nvidia.com/redist/optix/v7.6/OptiX-7.6-Include.zip
    # URL_HASH MD5=32f170454a9a6c944854ca6fef8c5ec1
)

FetchContent_MakeAvailable(Optix)

set(OPTIX_INCLUDE_PATH ${optix_SOURCE_DIR})