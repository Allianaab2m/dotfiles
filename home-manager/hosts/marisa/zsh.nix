{
  programs.zsh = {
    envExtra = ''
      export PATH=$PATH:/Users/alliana/.local/bin
      export PATH=$PATH:/Users/alliana/Library/Android/sdk/platform-tools
      export PATH=$PATH:/opt/homebrew/bin
      export PNPM_HOME=/Users/alliana/Library/pnpm
      export PATH=$PATH:$PNPM_HOME
      export SSH_AUTH_SOCK=/Users/alliana/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock

      source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc
      source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
    '';
  };
}
