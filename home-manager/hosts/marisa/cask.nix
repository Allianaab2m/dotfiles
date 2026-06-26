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
        hash = "sha256-H92sFAm/BJXSFdcACfVoxoVaqMgF8t2hdI9Aujk6Sg4=";
      };
    }))
  ];
  note = with pkgs.brewCasks; [
    notion
    obsidian
  ];
  dev = with pkgs.brewCasks; [
    gitify
    cmux
    coderabbit
  ];
  communication = with pkgs.brewCasks; [
    discord
    slack
  ];
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
    dev ++
    keybind ++
    communication ++
    misc ++ 
    [
      pkgs.brewCasks."visual-studio-code@insiders"
    ];
}
