{ pkgs, lib, ... }:
let
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "alacritty";
    sha256 = "1r2z223hza63v5lmzlg3022mlar67j3a2gh41rsaiqwja2wyiihz";
    rev = "f6cb5a5c2b404cdaceaff193b9c52317f62c62f7";
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        blur = true;
        opacity = 0.7;
        dimensions = {
          columns = 180;
          lines = 55;
        };
        position = {
          x = 300;
          y = 250;
        };
      };
      font = {
        size = 15;
        normal = {
          family = "PlemolJP35 Console NF";
          style = "Regular";
        };
      };
    } // lib.importTOML "${src}/catppuccin-mocha.toml";
  };
}
