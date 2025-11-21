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
        separator = " ➜  ";
      };
      modules = [
        {
          type = "os";
          key = "OS  ";
          keyColor = "31";
        }
        {
          type = "kernel";
          key = "├  ";
          keyColor = "31";
        }
        {
          type = "packages";
          key = "├ 󰏖 ";
          keyColor = "31";
        }
        {
          type = "shell";
          key = "└  ";
          keyColor = "31";
        }
        "break"
        {
          type = "wm";
          key = "WM  ";
          keyColor = "32";
        }
        {
          type = "wmtheme";
          key = "├ 󰀻 ";
          keyColor = "32";
        }
        {
          type = "terminal";
          key = "├  ";
          keyColor = "32";
        }
        {
          type = "terminalfont";
          key = "└  ";
          keyColor = "32";
        }
        "break"
        {
          type = "host";
          format = "{2}";
          key = "PC  ";
          keyColor = "33";
        }
        {
          type = "cpu";
          format = "{1} ({3}) @ {7}";
          key = "├  ";
          keyColor = "33";
        }
        {
          type = "gpu";
          format = "{2} @ {12}";
          key = "├ 󰢮 ";
          keyColor = "33";
        }
        {
          type = "memory";
          key = "├  ";
          keyColor = "33";
        }
        {
          type = "monitor";
          key = "├  ";
          keyColor = "33";
        }
        {
          type = "disk";
          key = "└  ";
          keyColor = "33";
        }
      ];
      logo = {
        type = "kitty-direct";
        source = "/Users/alliana/Pictures/github_icon.png";
        width = 32;
      };
    };
  };
}
