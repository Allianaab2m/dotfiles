{ lib, config, pkgs, homeManager, ... }:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
rec {
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
     gcc
  ];

  home.activation = {
    updateLinks = ''
    export ROOT="${home.homeDirectory}/dotfiles"
    ln -snf "$ROOT/config/atcoder-cli-nodejs" "${home.homeDirectory}/.config/"
    '';
  };

  home = {
    username = "alliana";
    homeDirectory = "/home/${home.username}";
    stateVersion = "24.05";
  };
}
