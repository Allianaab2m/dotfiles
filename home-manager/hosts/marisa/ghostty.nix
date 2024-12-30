{ ... }:
{
  home.file.".config/ghostty/config".text = ''
    shell-integration = zsh

    font-family = "PlemolJP35 Console NF"

    theme = "catppuccin-mocha"
    window-theme = "ghostty"

    background-opacity = 0.85
    background-blur-radius = 20

    macos-titlebar-style = transparent

    mouse-hide-while-typing = true

    cursor-opacity = 0.7
    cursor-style = block
    cursor-style-blink = false
    shell-integration-features = no-cursor
    resize-overlay = never
  '';
  # for CLI
  programs.zsh = {
    envExtra = ''
      export PATH=$PATH:/Applications/Ghostty.app/Contents/MacOS/
    '';
  };
}
