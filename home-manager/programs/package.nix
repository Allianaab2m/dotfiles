{ pkgs, ... }: 
let
  # CLI Tools
  misc = with pkgs; [
    bat delta fd ripgrep fzf lazygit tree eza which ghq fastfetch go-task jq _1password-cli curl unzip xdg-utils wget zellij
  ];
  # Language runtimes
  dev = with pkgs; [
    gcc nodejs-slim nodePackages.pnpm go python3 deno
  ];

  rust = with pkgs; [
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
  ];
in
{
  home.packages = misc ++ dev ++ rust;
}
