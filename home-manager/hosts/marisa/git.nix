{
  programs.git = {
    includes = [
      {
        condition = "gitdir:~/ghq/github.com/emobi-co-jp/";
        path = "~/ghq/github.com/emobi-co-jp/.gitconfig";
      }
    ];
  };
}
