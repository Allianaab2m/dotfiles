{ pkgs, ... }:
let
  # CLI Tools
  misc = with pkgs; [
    delta
    fd
    ripgrep
    fzf
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
    xdg-utils
    wget
    zellij
    lefthook
    zscroll
    postgresql
    viu
    yt-dlp
    ffmpeg
    gnupg
    zbar
  ];
  # Language runtimes
  dev = with pkgs; [
    # C/C++
    gcc
    nodejs_22
    pnpm_10
    deno
    go
    python3
    uv
    typst
    graphviz
    jdk
    turso-cli
  ];

  # Language server, formatter
  lsp = with pkgs; [
    vtsls
    pyright
    black
    isort
    nil
    nixfmt-rfc-style
    lua-language-server
    nodePackages.vscode-json-languageserver
    typos-lsp
  ];
in
{
  home.packages = misc ++ dev ++ lsp;
}
