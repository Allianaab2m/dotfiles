{...}: {
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

}
