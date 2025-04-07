{ pkgs, ... }:
{
  imports = [
    ./brew.nix
    ./system.nix
  ];

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
    };
  };

  # security.pam.enableSudoTouchIdAuth = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  fonts = {
    packages = with pkgs; [
      plemoljp-nf
      udev-gothic-nf
    ];
  };
}
