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
    delta
    fd
    ripgrep
    fzf
    lazygit
    tree
    eza
    which
    ghq
    fastfetch
    go-task
    jq
    _1password-cli
    curl
    unzip
    neovim
  ];
}
