{ pkgs, config, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsUnstable;
  };
}
