let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: [
      python-pkgs.pip
      python-pkgs.flask
      python-pkgs.django
      python-pkgs.numpy
      python-pkgs.opencv4
      python-pkgs.fastapi
      python-pkgs.pandas
      python-pkgs.requests
      python-pkgs.ipykernel
    ]))
  ];
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
    ]}
  '';
}

