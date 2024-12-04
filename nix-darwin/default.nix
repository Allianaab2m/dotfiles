{ pkgs, ... }: {
  imports = [
    ./system.nix
    ./brew.nix
  ];

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  services.nix-daemon.enable = true;

  fonts = {
    packages = with pkgs; [
      plemoljp-nf
    ];
  };
}
