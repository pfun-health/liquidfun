{
  description = "LiquidFun flake for Linux development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

  outputs = { self, nixpkgs, ... }@inputs:
    let

      inherit (self) outputs;

      supportedSystems = [ "x86_64-linux" ];

      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems
        (system: f { pkgs = import nixpkgs { inherit system; }; });

      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          buildInputs = [
            pkgs.cmake
            pkgs.mesa
            pkgs.libGLU
            pkgs.makeWrapper
            pkgs.xorg.libX11
            pkgs.xorg.libXext
            pkgs.xorg.libXrender
            pkgs.xorg.libXfixes
            pkgs.xorg.libXdamage
            pkgs.xorg.libXxf86vm
            pkgs.xorg.libxcb
            pkgs.python3
            pkgs.gcc
            pkgs.emscripten
          ];
          shellHook = ''
            echo "LiquidFun development shell. Use cmake and make to build:"
            echo -e "
                 cmake -G 'Unix Makefiles'
                 make
            "
          '';
        };
      });
    };
}
