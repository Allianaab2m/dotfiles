{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      display = {
        size = {
          binaryPrefix = "si";
        };
        percent = {
          type = 3;
        };
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "battery"
        "separator"
        "packages"
        "display"
        "de"
        "wm"
        "terminal"
        "terminalfont"
        "player"
        "media"
      ];
    };
  };
}
