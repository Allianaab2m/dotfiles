{
  description = "Alliana's nix configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    # Nix modules for darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      flakeRoot = ./.;
      homeManager = /${flakeRoot}/home-manager;
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # nix-darwin
      darwinConfigurations = {
        marisa = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./nix-darwin/default.nix
          ];
        };
      };

      homeConfigurations = {
        # youmu: Ubuntu 24.04.1 + WSL2 (Host: Windows 11 23H2)
        youmu-wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit
              inputs
              outputs
              flakeRoot
              homeManager
              ;
          };
          modules = [
            ./home-manager
            ./home-manager/hosts/youmu-wsl
          ];
        };

        # reimu: Ubuntu 24.04.1 + WSL2 (Host: Windows 11 23H2)
        reimu-wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit
              inputs
              outputs
              flakeRoot
              homeManager
              ;
          };
          modules = [
            ./home-manager
            ./home-manager/hosts/reimu-wsl
          ];
        };

        # marisa: macOS 15(Darwin)
        marisa = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./home-manager/default.nix
            ./home-manager/hosts/marisa/default.nix
          ];
        };
      };
    };
}
