{ ... }:
let
  # browser = [
  #   "arc"
  #   "google-chrome"
  # ];
  tools = [
    "tailscale-app"
    "azookey"
    "1password"
    "orbstack"
    "parsec"
    "raycast"
    "wireshark-app"
  ];
  # dev = [
  #   "gitify"
  #   "postman"
  #   "visual-studio-code@insiders"
  # ];
  # note = [
  #   "notion"
  #   "obsidian"
  # ];
  # communication = [
  #   "discord"
  #   "slack"
  # ];
  keybind = [
    "karabiner-elements"
    "homerow"
  ];
  msoffice = [
    "microsoft-word"
    "microsoft-excel"
    "microsoft-powerpoint"
    "windows-app"
  ];
  # misc = [
  #   "gimp"
  #   "inkscape"
  #   "raspberry-pi-imager"
  #   "obs"
  #   "jordanbaird-ice"
  #   "battery"
  #   "keycastr"
  #   "music-presence"
  # ];
in
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = tools ++ keybind ++ msoffice;
    brews = [
      "git-gtr"
    ];
  };
}
