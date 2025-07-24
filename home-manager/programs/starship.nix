{
  pkgs,
  lib,
  ...
}:
let
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "starship";
    rev = "31b224a6408015d1e17a5766de6b764cf9af3c1c";
    sha256 = "15nna6hmmz9awaazr4hjlnx3nsbmp7hgviym56bqlii6b032hdsf";
  };
in
{
  programs.starship = {
    enable = true;
    settings = {
      aws.disabled = true;
      gcloud.disabled = true;
      username = {
        disabled = false;
        show_always = true;
        format = "[$user]($style)@";
      };
      hostname = {
        ssh_only = false;
        format = "[$hostname](mauve) ";
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      gradle = {
        symbol = " ";
      };
      kotlin = {
        symbol = " ";
      };
      cmd_duration = {
        format = "⌛[$duration]($style) ";
      };
      directory = {
        truncation_length = 100;
        truncate_to_repo = false;
        truncation_symbol = "…/";
      };
      palette = "catppuccin_mocha";
    } // lib.importTOML "${src}/themes/mocha.toml";
  };
}
