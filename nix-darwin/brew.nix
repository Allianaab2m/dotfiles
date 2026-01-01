{ ... }:
let
  browser = [
    "arc"
    "google-chrome"
  ];
  tools = [
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
    "battery"
    "music-presence"
    "hhkb"
    "azookey"
  ];
  keybind = [
    "raycast"
    "karabiner-elements"
    "aerospace"
    "aeroindicator"
    "homerow"
  ];
  msoffice = [
    "microsoft-word"
    "microsoft-excel"
    "microsoft-powerpoint"
    "windows-app"
  ];
  chat = [
    "discord"
    "slack"
    "zoom"
  ];
  dev = [
    "orbstack"
    "visual-studio-code@insiders"
    "android-studio"
    "ghostty"
    "unity-hub"
    "intellij-idea"
    "rustrover"
    "gitify"
    "postman"
    "gcloud-cli"
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
      # Pulumi
      "pulumi/tap"
      # Terraform
      "hashicorp/tap"
      # jj-starship
      "dmmulroy/tap"
    ];
    casks = browser ++ tools ++ keybind ++ msoffice ++ chat ++ dev ++ note ++ font ++ game;
    brews = [
      "borders"
      "nowplaying-cli"
      "stripe/stripe-cli/stripe"
      "tcl-tk"
      "wireguard-tools"
      "pulumi"
      "esc"
      "opencode"
      "jj-starship"
    ];
    masApps = {
      Bitwarden = 1352778147;
    };
  };
}
