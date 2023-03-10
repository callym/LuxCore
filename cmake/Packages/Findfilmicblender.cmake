include(FetchContent)

FetchContent_Declare(
  filmicblender
  GIT_REPOSITORY https://github.com/sobotka/filmic-blender.git
  GIT_TAG master
  GIT_PROGRESS TRUE
)

FetchContent_MakeAvailable(filmicblender)