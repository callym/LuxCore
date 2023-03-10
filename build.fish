#!/usr/bin/fish

set python_version (python -c "from sys import version_info; print(\"%d%d\" % (version_info.major,version_info.minor))")
set -x CMAKE_FLAGS -DPYTHON_V=$python_version

cmake $CMAKE_FLAGS -S . -B build -G Ninja

ninja -j(math (nproc) '* 2 ') -C ./build
