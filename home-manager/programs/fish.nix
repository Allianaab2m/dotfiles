{ pkgs, ... } : {
  programs.fish = {
    enable = true;
    plugins = [
      { name = "pure"; src = pkgs.fishPlugins.pure; }
    ];
  };
}
