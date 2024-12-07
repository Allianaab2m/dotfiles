{
  programs.zsh = {
    shellAliases = {
      ssh = "ssh.exe";
    };
    envExtra = ''
      export PATH=$PATH:/mnt/c/wsl/ubuntu/bin
    '';
  };
}
