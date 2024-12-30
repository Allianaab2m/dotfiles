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
in
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    taps = [
      # for Aerospace
      "nikitabobko/tap"
      # for JankyBorders
      "FelixKratz/formulae"
    ];
    casks = browser ++ tools ++ keybind ++ msoffice ++ chat ++ dev ++ note;
    brews = [
      "borders"
    ];
  };
}
