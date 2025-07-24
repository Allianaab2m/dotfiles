{
  programs.zsh = {
    envExtra = ''
      export PATH=$PATH:/Users/alliana/.local/bin
      export PATH=$PATH:/Users/alliana/Library/Android/sdk/platform-tools
      export PATH=$PATH:/opt/homebrew/bin
      export PNPM_HOME=/Users/alliana/Library/pnpm
      export PATH=$PATH:$PNPM_HOME
    '';
  };
}
