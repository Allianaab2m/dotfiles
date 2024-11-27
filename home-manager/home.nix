{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "alliana";
in
{
  nixpkgs = {
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
  };
  home = {
    username = username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      git
      curl
      neovim
    ];
  };

  programs.home-manager.enable = true;
}
