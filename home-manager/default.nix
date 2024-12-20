{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./programs
  ];

  nixpkgs = {
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
      inputs.fenix.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;
}
