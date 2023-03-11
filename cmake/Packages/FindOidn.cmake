set(OIDN_STATIC_LIB ON)

git_declare(Oidn OpenImageDenoise/oidn v1.4.3)

FetchContent_GetProperties(Oidn)

if(NOT oidn_POPULATED)
	FetchContent_Populate(Oidn)
	add_subdirectory(${oidn_SOURCE_DIR} ${oidn_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

set_target_properties(OpenImageDenoise PROPERTIES EXCLUDE_FROM_ALL TRUE)

set(OIDN_FOUND TRUE)