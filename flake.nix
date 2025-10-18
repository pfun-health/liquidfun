{
  description = "LiquidFun flake for Linux development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [ pkgs.cmake pkgs.mesa pkgs.libGLU pkgs.makeWrapper ];
        shellHook = ''
          echo "LiquidFun development shell. Use cmake and make to build:"
          echo -e "
               cmake -G 'Unix Makefiles'
               make
          "
        '';
      };
    };
}
