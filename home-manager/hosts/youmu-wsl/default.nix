{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
  ];
}
