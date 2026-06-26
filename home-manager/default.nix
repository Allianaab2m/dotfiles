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
      # inputs.fenix.overlays.default
      # inputs.jj-starship.overlays.default
      (_f: p: {
        yt-dlp = p.yt-dlp.overridePythonAttrs (o: {
          # don't use gnome keyring
          dependencies = (
            __filter (
              p:
              !(__elem p.pname [
                "cffi"
                "secretstorage"
              ])
            ) o.dependencies
          );
        });
      })
      inputs.brew-nix.overlays.default
      inputs.nix-claude-code.overlays.default
      inputs.llm-agents.overlays.default
    ];
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;
}
