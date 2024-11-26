{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system}.extend (
      neovim-nightly-overlay.overlays.default
    );
  in
  {
    packages.${system}.my-packages = nixpkgs.legacyPackages.x86_64-linux.buildEnv {
      name = "my-packages-list";
      paths = with pkgs; [
        git
        curl
        neovim
      ];
    };
  };
}
