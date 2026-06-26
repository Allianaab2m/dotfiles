{ pkgs, lib, ... }:
{
  imports = [
    ./brew.nix
    ./system.nix
    ./services
  ];

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
    };

    settings = {
      extra-substituters = [
        "https://cache.numtide.com"
        "https://nix-community.cachix.org"
        "https://ab2m.cachix.org"
      ];
      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ab2m.cachix.org-1:gQOvR3a+Ttk401dA5hf/i8LvwanRFrtt7TUc7u2/lto="
      ];
      trusted-users = [ "root" "@wheel" ] ++ lib.optional pkgs.stdenv.isDarwin "@admin";
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
