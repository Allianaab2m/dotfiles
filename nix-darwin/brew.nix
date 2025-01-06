{ ... }:
let
  browser = [
    "arc"
    "google-chrome"
  ];
  tools = [
    "1password"
    "google-drive"
    "tailscale"
    "morisawa-desktop-manager"
    "readdle-spark"
    "logseq"
    "obsidian"
  ];
  keybind = [
    "raycast"
    "karabiner-elements"
    "aerospace"
  ];
  msoffice = [
    "microsoft-word"
    "microsoft-excel"
    "microsoft-powerpoint"
  ];
  chat = [ "discord" ];
  dev = [
    "orbstack"
    "visual-studio-code@insiders"
    "android-studio"
    "utm"
    "ghostty"
  ];
  note = [
    "notion"
    "anytype"
  ];
  font = [
    "font-sf-pro"
    "sf-symbols"
    "font-sketchybar-app-font"
  ];
in
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    taps = [
      # for Aerospace
      "nikitabobko/tap"
      # for JankyBorders
      "FelixKratz/formulae"
    ];
    casks = browser ++ tools ++ keybind ++ msoffice ++ chat ++ dev ++ note ++ font;
    brews = [
      "borders"
      "sketchybar"
      "nowplaying-cli"
    ];
  };
}
