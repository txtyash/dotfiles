{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = (import (inputs.nixpkgs) { inherit system; });
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            libsForQt5.qt5.qtdeclarative
            libsForQt5.qt5.qtimageformats
            libsForQt5.qt5.qtmultimedia
            libsForQt5.qt5.qtsvg
            quickshell
          ];
        };
      }
    );
}
