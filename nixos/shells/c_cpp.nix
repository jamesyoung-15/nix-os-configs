with import <nixpkgs> {};
mkShell {
  nativeBuildInputs = [ pkg-config cmake ];
  buildInputs = [ 
        boost 
        # builder
        gnumake
        cmake
        bear

        # debugger
        lldb
        gdb

        # fix headers not found
        clang-tools

        # other tools
        cppcheck
        libllvm
        valgrind
        ccls

          
        # libs
        glm
        SDL2
        SDL2_gfx
    ];
}