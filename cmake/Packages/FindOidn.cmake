include(FetchContent)

set(OIDN_STATIC_LIB ON)

FetchContent_Declare(
	Oidn
	GIT_REPOSITORY https://github.com/OpenImageDenoise/oidn.git
	GIT_TAG v1.4.3
	GIT_PROGRESS TRUE
	GIT_SHALLOW 1
	OVERRIDE_FIND_PACKAGE

	PATCH_COMMAND
	${CMAKE_COMMAND}
	-Din_file:FILEPATH=${FETCHCONTENT_BASE_DIR}/oidn-src/cmake/oidn_install.cmake
	-Dpatch_file:FILEPATH=${CMAKE_CURRENT_SOURCE_DIR}/cmake/Packages/patches/oidn-src/cmake/oidn_install.patch
	-Dout_file:FILEPATH=${FETCHCONTENT_BASE_DIR}/oidn-src/cmake/oidn_install.cmake
	-P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Utils/PatchFile.cmake
)

FetchContent_GetProperties(Oidn)

if(NOT oidn_POPULATED)
	FetchContent_Populate(Oidn)
	add_subdirectory(${oidn_SOURCE_DIR} ${oidn_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

set_target_properties(OpenImageDenoise PROPERTIES EXCLUDE_FROM_ALL TRUE)

set(OIDN_FOUND TRUE)
set(OIDN_LIBRARY OpenImageDenoise)
