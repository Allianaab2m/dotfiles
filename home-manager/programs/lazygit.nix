{
  pkgs,
  config,
  ...
}:
let
  enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;
  configDir =
    if enableXdgConfig then
      config.xdg.configHome
    else
      "${config.home.homeDirectory}/Library/Application Support";

  configFile = "${configDir}/lazygit/config.yml";
in
{
  config.programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };
}
