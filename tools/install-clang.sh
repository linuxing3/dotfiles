install_clangd() {

    sudo apt install clangd-11
    sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-11 100

}

install_clangtools() {

    sudo apt install clang-tools

}

configure_cmake_clang_project() {

    echo CMake-based projects

    echo If your project builds with CMake, it can generate this file. You should enable it with:

    echo cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1

    echo compile_commands.json will be written to your build directory.

    echo If your build directory is $SRC or $SRC/build, clangd will find it. Otherwise, symlink or copy it to $SRC, the root of your source tree.

    echo ln -s ~/myproject-build/compile_commands.json ~/myproject/

}
