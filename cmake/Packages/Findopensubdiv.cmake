set(NO_DOC ON CACHE INTERNAL "")
set(NO_EXAMPLES ON CACHE INTERNAL "")
set(NO_TUTORIALS ON CACHE INTERNAL "")
set(NO_REGRESSION ON CACHE INTERNAL "")
set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "")

set(OSD_CUDA_NVCC_FLAGS "--gpu-architecture native" CACHE INTERNAL "")

git(opensubdiv Logarithmus/OpenSubdiv tbb-2021)

set(OPENSUBDIV_INCLUDE_PATH ${opensubdiv_SOURCE_DIR})
set(OSD_LIBRARY osd_static_gpu osd_static_cpu)
