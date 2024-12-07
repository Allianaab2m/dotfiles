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
      function _fzf_cd_ghq() {
        FZF_DEFAULT_OPTS="''${FZF_DEFAULT_OPTS} --reverse --height=50%"
        local root="$(ghq root)"
        local repo="$(ghq list | fzf --preview="ls -AF --color=always ''${root}/{1}")"
        local dir="''${root}/''${repo}"
        [ -n "''${dir}" ] && cd "''${dir}"
        zle accept-line
        zle reset-prompt
      }

      zle -N _fzf_cd_ghq
      bindkey "^g" _fzf_cd_ghq
      eval "$(direnv hook zsh)"
    '';
  };
}
