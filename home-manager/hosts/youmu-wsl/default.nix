{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
     gcc
  ];
}
