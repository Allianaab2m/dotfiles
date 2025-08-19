{ ... }:
let
  browser = [
    "arc"
    "google-chrome"
  ];
  tools = [
    "1password"
    "google-drive"
    "tailscale-app"
    "morisawa-desktop-manager"
    "readdle-spark"
    "logseq"
    "obsidian"
    "raspberry-pi-imager"
    "adobe-acrobat-reader"
    "obs"
    "gimp"
    "inkscape"
    "jordanbaird-ice"
    "ltspice"
  ];
  keybind = [
    "raycast"
    "karabiner-elements"
    "aerospace"
    "aeroindicator"
  ];
  msoffice = [
    "microsoft-word"
    "microsoft-excel"
    "microsoft-powerpoint"
  ];
  chat = [
    "discord"
    "slack"
  ];
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
    "gitify"
    "postman"
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
    "font-maple-mono-nf"
  ];
  game = [
    "prismlauncher"
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
      # Turso
      "tursodatabase/tap"
      # AeroIndicator
      "rien7/apps"
      # Apple Music Discord Rpc
      "nextfire/tap"
    ];
    casks = browser ++ tools ++ keybind ++ msoffice ++ chat ++ dev ++ note ++ font ++ game;
    brews = [
      "borders"
      "nowplaying-cli"
      "stripe/stripe-cli/stripe"
      "tcl-tk"
      "wireguard-tools"
      {
        name = "apple-music-discord-rpc";
        restart_service = "changed";
      }
    ];
  };
}
