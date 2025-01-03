# Marisa - Apple M3 MacBook Air 13"
{
  lib,
  config,
  pkgs,
  homeManager,
  ...
}:
let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in
rec {
  imports = [
    ./alacritty.nix
    ./aerospace.nix
    ./git.nix
    ./ghostty.nix
    ./sketchybar.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    jdk21
  ];

  home.activation = {
    updateLinks = ''
      export ROOT="${home.homeDirectory}/dotfiles"
      ln -snf "$ROOT/config/atcoder-cli-nodejs" "${home.homeDirectory}/.config/"
    '';
  };

  home = {
    username = "alliana";
    homeDirectory = "/Users/${home.username}";
    stateVersion = "24.11";
  };

  # Remove `Last login:` prompt
  home.file.".hushlogin" = {
    text = "";
  };

  targets.darwin.defaults = {
    # DS_Store
    "com.apple.desktopservices" = {
      DSDontWriteUSBStores = true;
      DSDontWriteNetworkStores = true;
    };
  };
}
