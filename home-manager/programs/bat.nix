{
  pkgs,
  ...
}: {
  programs.bat = {
    enable = true;
    themes = {
      "Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
          sha256 = "0v46lfx9fjg1a36w5n9q424j2v017vhf2gf2znqi985f4lyalp67";
        };
        file = "themes/Catppuccin\ Mocha.tmTheme";
      };
    };
    config = {
      theme = "Catppuccin Mocha";
    };
  };
}
