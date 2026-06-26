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
    ghostscript
    pure-prompt
  ];
  # Language runtimes
  dev = with pkgs; [
    # C/C++
    gcc
    go
    uv
    typst
    graphviz
    jdk
    turso-cli
    # mise
    tex-fmt
    coursier
    sleek
    google-cloud-sdk
    pulumi
    pulumi-esc
    pulumiPackages.pulumi-nodejs
    cloudflared
    tree-sitter
    stripe-cli
    # opencode
    wireguard-tools
    claude-code
  ];
  # Language server, formatter
  lsp = with pkgs; [
    vtsls
    pyright
    black
    isort
    nil
    nixfmt
    lua-language-server
    vscode-json-languageserver
    typos-lsp
  ];
  llm = with pkgs; [
    llm-agents.codex
  ];
in
{
  home.packages = misc ++ dev ++ lsp ++ llm;
}
