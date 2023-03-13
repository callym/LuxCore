# ###############################################################################
# Copyright 1998-2020 by authors (see AUTHORS.txt)
#
# This file is part of LuxCoreRender.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ###############################################################################

macro(git_declare name repository tag)
  include(FetchContent)

  set(repo ${repository})

  if(NOT ${repo} MATCHES "^https://")
    set(repo "https://github.com/${repository}.git")
  endif()

  FetchContent_Declare(
    ${name}
    GIT_REPOSITORY ${repo}
    GIT_TAG ${tag}
    GIT_PROGRESS TRUE
    GIT_SHALLOW 1
    OVERRIDE_FIND_PACKAGE
  )
endmacro()

macro(git name repository tag)
  git_declare(${name} ${repository} ${tag})

  FetchContent_MakeAvailable(${name})
endmacro()
