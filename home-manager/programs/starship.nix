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
    enable = false;
    settings = lib.importTOML "${src}/themes/mocha.toml" // {
      aws.disabled = true;
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      gradle = {
        symbol = " ";
      };
      kotlin = {
        symbol = " ";
      };
      docker_context = {
        symbol = "󰡨 ";
        format = "[$symbol$context]($style) ";
      };
      cmd_duration = {
        format = "[󰔚 $duration]($style) ";
      };
      gcloud = {
        symbol = "󱇶 ";
        format = "[$symbol$project]($style) ";
      };
      git_status = {
        format = "([\$all_status$ahead_behind]($style) )";
        ahead = "⇡$\{count\}";
        behind = "⇣$\{count\}";
      };
      nodejs = {
        format = "[$symbol$version]($style) ";
      };
      directory = {
        truncation_length = 2;
        truncate_to_repo = false;
        truncation_symbol = "…/";
        fish_style_pwd_dir_length = 1;
        format = "[$path]($style) ";
      };
      package = {
        symbol = "󰏓 ";
        format = "[$symbol$version]($style) ";
        display_private = true;
      };
      pulumi = {
        symbol = " ";
        format = "[$symbol$stack]($style) ";
      };
      palette = "catppuccin_mocha";
    };
  };
}
