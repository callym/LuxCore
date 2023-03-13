SET(BCD_BUILD_GUI OFF)

git(bcd callym/bcd cmake)

SET(BCD_USE_CUDA OFF)

set(BCD_INCLUDES ${bcd_SOURCE_DIR}/include)