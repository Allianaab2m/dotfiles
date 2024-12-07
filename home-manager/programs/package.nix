{ pkgs, ... }: 
let
  # CLI Tools
  misc = with pkgs; [
    delta fd ripgrep fzf tree eza which ghq fastfetch go-task jq _1password-cli curl unzip xdg-utils wget zellij
  ];
  # Language runtimes
  dev = with pkgs; [
    gcc nodejs_22 nodePackages.pnpm go python3 deno typst
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
