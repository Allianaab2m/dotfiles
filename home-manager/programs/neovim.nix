{ pkgs, config, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
    extraPackages = with pkgs; [
      lua-language-server
      typescript-language-server
      gopls
      nil
      pyright
      stylua
      nixfmt
    ];
  };

  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;

  home.activation.linkNvimConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -snf "${config.home.homeDirectory}/dotfiles/config/nvim" "${config.home.homeDirectory}/.config/nvim"
  '';
}
