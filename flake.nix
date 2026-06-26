{
  description = "Alliana's nix configurations";

  nixConfig = {
    extra-substituters = [
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
      "https://ab2m.cachix.org"
    ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "ab2m.cachix.org-1:gQOvR3a+Ttk401dA5hf/i8LvwanRFrtt7TUc7u2/lto="
    ];
  };

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
    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
    nix-claude-code = {
      url = "github:ryoppippi/nix-claude-code";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      brew-nix,
      nix-claude-code,
      nix-index-database,
      llm-agents,
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
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

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
            nix-index-database.homeModules.default
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
            nix-index-database.homeModules.default
            ./home-manager
            ./home-manager/hosts/reimu-wsl
          ];
        };

        # marisa: macOS 15(Darwin)
        marisa = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            nix-index-database.homeModules.default
            ./home-manager/default.nix
            ./home-manager/hosts/marisa/default.nix
          ];
        };
      };

      devShells.aarch64-darwin.default =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin
        in
        pkgs.mkShellNoCC {
          packages = with pkgs; [
            lua-language-server
            vim-language-server
            yaml-language-server
            nil
          ];
        };
    };
}
