set(NO_DOC ON)
set(NO_EXAMPLES ON)
set(NO_TUTORIALS ON)
set(NO_REGRESSION ON)
set(BUILD_SHARED_LIBS OFF)

set(OSD_CUDA_NVCC_FLAGS "--gpu-architecture native")

git(opensubdiv Logarithmus/OpenSubdiv tbb-2021)
