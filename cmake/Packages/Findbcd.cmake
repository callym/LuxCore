SET(BCD_BUILD_GUI OFF CACHE INTERNAL "")

git(bcd callym/bcd cmake)

set(BCD_INCLUDES ${bcd_SOURCE_DIR}/include)