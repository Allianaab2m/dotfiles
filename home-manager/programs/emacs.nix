{ pkgs, config, ... }:
{
  programs.emacs = {
    enable = false;
    package = pkgs.emacsUnstable;
  };
}
