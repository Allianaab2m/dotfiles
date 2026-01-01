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
      # inputs.fenix.overlays.default
      # inputs.jj-starship.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;
}
