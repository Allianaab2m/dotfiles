{
  lib,
  config,
  pkgs,
  homeManager,
  inputs,
  ...
}:
let 
  browser = with pkgs.brewCasks; [
    arc
    (google-chrome.overrideAttrs (oldAttrs: {
      src = pkgs.fetchurl {
        url = builtins.head oldAttrs.src.urls;
        hash = "sha256-AHygUjSFN5kuiE4e2k3Ou3hza28ENmRAkBRxqDxXO6Y=";
      };
    }))
  ];
  note = with pkgs.brewCasks; [
    notion
    obsidian
  ];
  dev = with pkgs.brewCasks; [
    gitify
    postman
  ];
  communication = with pkgs.brewCasks; [
    discord
    slack
  ];
  # msoffice = with pkgs.brewCasks; [
  #   microsoft-word
  #   (lib.hiPrio microsoft-excel)
  #   microsoft-powerpoint
  #   (windows-app.overrideAttrs (oldAttrs: {
  #     unpackPhase = ''
  #       set -euo pipefail
  #       xar -xf "$src" com.microsoft.rdc.macos.pkg/Payload
  #       gzip -d < com.microsoft.rdc.macos.pkg/Payload | cpio -idm
  #     '';
  #     nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [pkgs.cpio pkgs.gzip];
  #   }))
  # ];
  keybind = with pkgs.brewCasks; [
    homerow
  ];
  misc = with pkgs.brewCasks; [
    gimp
    inkscape
    raspberry-pi-imager
    obs
    jordanbaird-ice
    battery
    keycastr
  ];
in
{
  home.packages =
    browser ++
    note ++
    keybind ++
    misc ++ 
    [
      pkgs.brewCasks."visual-studio-code@insiders"
    ];
}
