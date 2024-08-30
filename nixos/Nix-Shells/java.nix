with import <nixpkgs> {};
mkShell {
  # Can replace with any jdk version available in nix packages
  buildInputs = [ pkgs.jdk11 ];
  shellHook = ''
      export JAVA_HOME=${pkgs.jdk11}
      PATH="${pkgs.jdk11}/bin:$PATH"
    '';
}