{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    zsh-abbr.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
      grep = "rg";
      ls = "eza --icons always --classify always";
      la = "eza --icons always --classify always --all";
      ll = "eza --icons always --long --all --git";
      tree = "eza --icons always --classify always --tree --git-ignore";
      acc = "pnpm acc";
      dot = "cd ~/dotfiles";
    };
    envExtra = ''
      . "$HOME/.cargo/env"

      export PATH="$HOME/.local/share/mise/shims:$PATH"
      export PATH="$PATH:/Users/alliana/.turso"
    '';
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

      clone() {
        command -v ghq || return 1
        ghq get --partial blobless "$1"
        local target
        target=$(echo "$1" | sed -r 's;https?://[^/]+|\.git$;;')
        local dir
        dir=$(ghq list | grep --color=never --fixed-strings "$target")
        [ -n "$dir" ] && cd "$(ghq root)/$dir" || return
        git dead
        git single
      }

      zle -N _fzf_cd_ghq
      bindkey "^g" _fzf_cd_ghq
      eval "$(direnv hook zsh)"
    '';
    zsh-abbr.abbreviations = {
      ga = "git add";
      gcm = "git commit";
      gsw = "git switch";
      gst = "git status";
      gush = "git push";
      gul = "git pull";
      g = "git";
    };
  };
}
