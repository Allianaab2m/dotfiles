{ ... }:
{
  home.file.".config/ghostty/config".text = ''
    font-family = "PlemolJP35 Console NF"
    theme = "catppuccin-mocha"
    window-theme = "ghostty"
    background-opacity = 0.85
    background-blur-radius = 20
    macos-titlebar-style = transparent
  '';
  # for CLI
  programs.zsh = {
    envExtra = ''
      export PATH=$PATH:/Applications/Ghostty.app/Contents/MacOS/
    '';
  };
}
