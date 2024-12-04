{ pkgs, ... }: {
  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  system = {
    stateVersion = 5;
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        # 長押しして出てくるアクセントメニューを消す
        ApplePressAndHoldEnabled = false;
        # キーリピート
        InitialKeyRepeat = 11;
        KeyRepeat = 2;
        "com.apple.mouse.tapBehavior" = 1;
      };
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "left";
        mineffect = "scale";
        minimize-to-application = true;
        wvous-br-corner = 1;
      };
      screencapture = {
        disable-shadow = true;
      };
      controlcenter = {
        BatteryShowPercentage = true;
      };
      WindowManager = {
        EnableTiledWindowMargins = false;
      };
      trackpad = {
        Clicking = true;
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    casks = [
      "1password"
      "raycast"
      "karabiner-elements"
      "arc"
      "notion"
      "discord"
      "microsoft-word"
      "microsoft-powerpoint"
      "microsoft-excel"
      "google-drive"
      "orbstack"
      "visual-studio-code@insiders"
    ];
  };

  fonts = {
    packages = with pkgs; [
      plemoljp-nf
    ];
  };
}
