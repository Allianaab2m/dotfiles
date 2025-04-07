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
  ];
  # Language runtimes
  dev = with pkgs; [
    # C/C++
    gcc
    nodejs_22
    nodePackages.pnpm
    deno
    go
    python3
    uv
    typst
    graphviz
    jdk
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
