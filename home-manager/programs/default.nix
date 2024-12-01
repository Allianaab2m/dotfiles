{ pkgs, ... }:
{
  imports = [
    ./direnv.nix
    ./starship.nix
    ./git.nix
    ./gh.nix
    ./package.nix
    ./neovim.nix
    ./zellij.nix
    ./zsh.nix
  ];
}
