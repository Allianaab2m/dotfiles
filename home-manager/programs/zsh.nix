{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
      grep = "rg";
      ls = "eza --icons always --classify always";
      la = "eza --icons always --classify always --all";
      ll = "eza --icons always --long --all --git";
      tree = "eza --icons always --classify always --tree";
      acc = "pnpm acc";
      dot = "cd ~/dotfiles";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
