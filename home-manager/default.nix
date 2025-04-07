{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./programs
  ];

  nixpkgs = {
    overlays = [
      inputs.fenix.overlays.default
      (import (
        builtins.fetchTarball {
          url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
          sha256 = "17ixcpiml5axvwrlqbp7xb386jkg1lc0hpzfvixfm5xzk94c1g4y";
        }
      ))
    ];
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;
}
