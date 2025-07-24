{
  programs.git = {
    extraConfig = {
      gpg = {
        "ssh".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
    };
    includes = [
      {
        condition = "gitdir:~/ghq/github.com/emobi-co-jp/";
        path = "~/ghq/github.com/emobi-co-jp/.gitconfig";
      }
    ];
  };
}
