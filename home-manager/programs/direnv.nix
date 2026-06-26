{
  pkgs,
  ...
}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    package = pkgs.direnv.overrideAttrs (oldAttrs: {
      env = (oldAttrs.env or { }) // { CGO_ENABLED = "1"; };
      doCheck = false;
    });
  };
}
