{
  pkgs,
  config,
  ...
}: 
  let
    enableXdgConfig = !pkgs.stdenv.hostPlatform.isDarwin || config.xdg.enable;
    configDir = if enableXdgConfig then
      config.xdg.configHome
    else
      "${config.home.homeDirectory}/Library/Application Support";

    configFile = "${configDir}/lazygit/config.yml";

    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "lazygit";
      rev = "d3c95a67ea3f778f7705d8ef814f87ac5213436d";
      sha256 = "01vhir6243k9wfvlgadv7wsc2s9yb92l67piqsl1dm6kwlhshr3g";
    };
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

  config.home.sessionVariables = {
    LG_CONFIG_FILE = "${src}/themes-mergable/mocha/sapphire.yaml,${configFile}";
  };
}
