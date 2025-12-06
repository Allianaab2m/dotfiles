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

  security = {
    pam = {
      services = {
        sudo_local.touchIdAuth = true;
        sudo_local.watchIdAuth = true;
      };
    };
  };

  fonts = {
    packages = with pkgs; [
      plemoljp-nf
      udev-gothic-nf
    ];
  };
}
