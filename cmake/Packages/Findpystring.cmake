git(pystring imageworks/pystring v1.1.4)

add_library(
    pystringstatic
    STATIC
    ${pystring_SOURCE_DIR}/pystring.cpp
    ${pystring_SOURCE_DIR}/pystring.h
)
add_library(pystring::pystring ALIAS pystringstatic)