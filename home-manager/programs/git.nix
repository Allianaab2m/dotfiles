{
  programs.git = {
    enable = true;
    userName = "Alliana";
    userEmail = "56180684+Allianaab2m@users.noreply.github.com";
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFLmR7uSY/Aj8w5VeojtLp8w0ba4tQnUIOzoe8GMkvsM";
      signByDefault = true;
    };
    aliases = {
      ad = "add -A";
      st = "status";
      sw = "switch";
      swc = "switch -c";
      cm = "commit -m";
      al = "config --get-regexp ^alias\\.";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      gpg = {
        format = "ssh";
      };
      url = {
        "git@github.com:" = {
          pushInsteadOf = "https://github.com";
        };
      };
    };
  };
}
