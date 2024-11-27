{
  description = "Alliana's nix configurations";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      username = "alliana";
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];

      homeManagerModules = import ./modules/home-manager;

      homeConfigurations = {
        youmu-wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs username;
            homeDirectory = "/home/${username}";
          };
          modules = [
            ./home-manager
            ./home-manager/hosts/youmu-wsl
          ];
        };
        # marisa = home-manager.lib.homeManagerConfiguration {
        #   pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        #   extraSpecialArgs = { inherit inputs outputs; };
        #   modules = [
        #     ./home-manager/home.nix
        #     ./home-manager/hosts/marisa
        #   ];
        # };
      };
    };
}
