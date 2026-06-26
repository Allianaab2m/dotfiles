{ ... }:
let
  tools = [
    "tailscale-app"
    "azookey"
    "1password"
    "orbstack"
    "parsec"
    "raycast"
    "wireshark-app"
    "cursor"
  ];
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
in
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
      # Homebrew 5.x で `brew bundle --cleanup` 単体は禁止され、
      # --force / --force-cleanup / $HOMEBREW_ASK が必須になったため付与する。
      extraFlags = [ "--force-cleanup" ];
    };
    taps = [
      "encoredev/tap"
    ];
    casks = tools ++ keybind ++ msoffice;
    brews = [
      "git-gtr"
      "encoredev/tap/encore"
    ];
  };
}
