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
        # Fnキーを押さなくてもF1~F12が使えるように
        "com.apple.keyboard.fnState" = true;
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
        # 右下にカーソル動かしたら出るメモを無効化
        wvous-br-corner = 1;
        # for Aerospace + Mission Control
        expose-group-apps = true;
      };
      # Fnキーで入力ソースを切り替えない
      hitoolbox = {
        AppleFnUsageType = "Do Nothing";
      };
      screencapture = {
        location = "/Users/alliana/Pictures/screenshot";
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
