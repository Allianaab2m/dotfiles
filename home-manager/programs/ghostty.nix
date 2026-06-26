{ pkgs, ... }: {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.isLinux then
        pkgs.ghostty
      else if pkgs.stdenv.isDarwin then
        pkgs.brewCasks.ghostty
      else
        throw "Unsupported platform ${pkgs.stdenv.hostPlatform}";
    settings = {
      font-family = "\"PlemolJP35 Console NF\"";
      font-feature = "calt, ss02, ss04, cv11, cv08";
      font-thicken = true;

      theme = "Catppuccin Mocha";
      window-theme = "ghostty";

      background-opacity = 0.50;
      background-blur-radius = 10;

      macos-titlebar-style = "transparent";

      mouse-hide-while-typing = true;

      cursor-opacity = 0.7;
      cursor-style = "block";
      cursor-style-blink = false;
      shell-integration-features = "no-cursor";
      resize-overlay = "never";

      keybind = [
        "global:alt+shift+t=toggle_quick_terminal"
      ];

      link-url = true;
      quick-terminal-size = "50%,1200px";
      macos-window-buttons = "hidden";
    };
  };
}
