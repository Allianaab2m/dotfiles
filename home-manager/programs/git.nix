{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Alliana";
        email = "56180684+Allianaab2m@users.noreply.github.com";
      };
      aliases = {
        ad = "add -A";
        st = "status";
        sw = "switch";
        swc = "switch -c";
        cm = "commit -m";
        al = "config --get-regexp ^alias\\.";
        remote-head = "symbolic-ref refs/remotes/origin/HEAD";
        default-branch = "!git remote-head | sed 's!.*/!!'";
        refresh = "fetch --all --prune";
        dead = "!git refresh --quiet && git switch -d $(git remote-head)";
        single = "!git branch | grep -v HEAD | xargs --no-run-if-empty git branch -d";
      };
      init = {
        defaultBranch = "main";
      };
      gpg = {
        format = "ssh";
        "ssh".allowedSignersFile = "~/.ssh/allowed_signers";
      };
      url = {
        "git@github.com:" = {
          pushInsteadOf = "https://github.com/";
        };
      };
      push = {
        autoSetupRemote = true;
      };
      ghq = {
        user = "Allianaab2m";
      };
      core = {
        pager = "delta";
      };
    };
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFLmR7uSY/Aj8w5VeojtLp8w0ba4tQnUIOzoe8GMkvsM";
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
    ];
    # extraConfig = {
    # };
  };
}
