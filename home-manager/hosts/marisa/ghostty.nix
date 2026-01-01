{ ... }:
{
  home.file.".config/ghostty/config".text = ''
    shell-integration = zsh

    font-family = "PlemolJP35 Console NF"
    font-feature = "calt, ss02, ss04, cv11, cv08"
    font-size = 12


    theme = Catppuccin Mocha
    window-theme = "ghostty"
    macos-titlebar-style = "hidden"

    background-opacity = 0.50
    background-blur-radius = 10

    macos-titlebar-style = transparent

    mouse-hide-while-typing = true

    cursor-opacity = 0.7
    cursor-style = block
    cursor-style-blink = false
    shell-integration-features = no-cursor
    resize-overlay = never

    keybind = global:alt+shift+t=toggle_quick_terminal

    link-url = true
    quick-terminal-size = 50%,1200px
    macos-window-buttons = hidden
  '';
  # for CLI
  programs.zsh = {
    envExtra = ''
      export PATH=$PATH:/Applications/Ghostty.app/Contents/MacOS/
    '';
  };
}
