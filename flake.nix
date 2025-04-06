{
  description = "Obsidian Slides";

  nixConfig = {
    warn-dirty = false;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            warn-dirty = false;
          };
        };
      in
      { 
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            marp-cli
            chromium # Required for PDF/PPTX export
          ];

          shellHook = ''
            export DIRENV_WARN_TIMEOUT=TRUE
            export PORT=8081
            echo "Marp CLI development environment loaded"
            marp -w -s ./
          '';
        };
    });
}

