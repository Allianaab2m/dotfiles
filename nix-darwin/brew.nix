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
    "raspberry-pi-imager"
    "adobe-acrobat-reader"
    "obs"
    "gimp"
    "inkscape"
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
    "unity-hub"
    "intellij-idea"
    "ollama"
    "rustrover"
    "xcodes"
  ];
  note = [
    "notion"
    "anytype"
  ];
  font = [
    "font-sf-pro"
    "sf-symbols"
    "font-sketchybar-app-font"
    "font-ibm-plex-sans-jp"
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
      "nowplaying-cli"
    ];
  };
}
