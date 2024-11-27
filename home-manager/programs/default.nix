{ pkgs, ... }:
{
  imports = [
    ./starship.nix
    ./git.nix
    ./gh.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    bat
    fd
    fzf
    lazygit
    tree
    eza
    which
    ghq
  ];
}
