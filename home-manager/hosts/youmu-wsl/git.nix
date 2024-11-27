{
  programs.git = {
    extraConfig = {
      core = {
        sshCommand = "ssh.exe";
      };
      gpg = {
        "ssh".program = "/mnt/c/Users/alliana/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
      };
    };
  };
}
