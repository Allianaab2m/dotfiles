{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "alliana";
in
{
  nixpkgs = {
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };
  
  home = {
    username = username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";

    packages = with pkgs; [
      git
      gh
      ghq
      bat
      delta
      fd
      ripgrep
      eza
      lazygit
      fzf
      tre
      fastfetch
      go-task
      jq
      _1password
      curl
      neovim
    ];
  };

  programs.home-manager.enable = true;
  
  programs.git = {
    enable = true;
    userName = "Alliana";
    userEmail = "56180684+Allianaab2m@users.noreply.github.com";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFLmR7uSY/Aj8w5VeojtLp8w0ba4tQnUIOzoe8GMkvsM";
      gpgPath = "ssh.exe";
      signByDefault = true;
    };
    extraConfig = {
      core = {
        pager = "delta";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true; # 自動補完
    autosuggestion.enable = true; # 入力サジェスト
    syntaxHighlighting.enable = true; # シンタックスハイライト
    shellAliases = {
      cat = "bat";
      grep = "rg";
      ls = "eza --icons always --classify always";
      la = "eza --icons always --classify always --all ";
      ll = "eza --icons always --long --all --git ";
      tree = "eza --icons always --classify always --tree";
    };
    envExtra = ''
    export PATH=$PATH:/mnt/c/wsl/ubuntu/bin
    '';
  };

  programs.starship = {
    enable = true;
  };
}
