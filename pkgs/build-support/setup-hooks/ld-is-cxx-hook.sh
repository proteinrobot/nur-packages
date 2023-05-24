ld-is-cxx-hook() {
    LD=$CXX
}

postHooks+=(ld-is-cxx-hook)