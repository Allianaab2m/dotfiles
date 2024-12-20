{...}: 
  let
    browser = ["arc" "google-chrome"];
    tools = ["1password" "google-drive" "tailscale" "morisawa-desktop-manager" "readdle-spark" "logseq"];
    keybind = ["raycast" "karabiner-elements" "aerospace"];
    msoffice = ["microsoft-word" "microsoft-excel" "microsoft-powerpoint"];
    chat = ["discord"];
    dev = ["orbstack" "visual-studio-code@insiders" "android-studio" "utm"];
    note = ["notion" "anytype"];
  in 
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };
    casks = browser ++ tools ++ keybind ++ msoffice ++ chat ++ dev ++ note;
    taps = [
      "nikitabobko/tap"
    ];
  };

}
