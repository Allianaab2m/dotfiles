{
  inputs,
  outputs,
  username,
  homeDirectory,
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
    overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = username;
    homeDirectory = homeDirectory;
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";
}
