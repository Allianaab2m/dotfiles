{ pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./delta.nix
    ./direnv.nix
    ./fastfetch.nix
    ./git.nix
    ./gh.nix
    ./lazygit.nix
    ./neovim.nix
    ./package.nix
    ./starship.nix
    ./zellij.nix
    ./zsh.nix
  ];
}
