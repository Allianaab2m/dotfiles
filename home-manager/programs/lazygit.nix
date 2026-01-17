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
      gui = {
        nerdFontsVersion = "3";
        spinner = {
          frames = ["" "" "" "" "" ""];
          rate = 100;
        };
      };
      git = {
        pagers = [
          { pager = "delta --dark --paging=never"; }
        ];
        allBranchesLogCmds = [
          "git log --graph --color=always --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(#a0a0a0 reverse)%h%Creset %C(cyan)%ad%Creset %C(#dd4814)%ae%Creset %C(yellow reverse)%d%Creset %n%C(white bold)%s%Creset%n' --"
        ];
        # branchLogCmd = "git log --graph --color=always --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' {{branchName}} --";
        branchLogCmd = "sh -c 'git log --graph --color=always --abbrev-commit --decorate --oneline {{branchName}} -- | sed -e s/\\\\*// -e s/\\\\|/│/'";
      };
    };
  };
}
