{...}: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
    };
    casks = [
      "1password"
      "raycast"
      "karabiner-elements"
      "arc"
      "notion"
      "discord"
      "microsoft-word"
      "microsoft-powerpoint"
      "microsoft-excel"
      "google-drive"
      "orbstack"
      "visual-studio-code@insiders"
      "tailscale"
    ];
  };

}
