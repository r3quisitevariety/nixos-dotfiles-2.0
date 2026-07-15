{
  config,
  pkgs,
  ...
}: {
  # syncs files from ./config in ~/.config/nvim; allows for live edits of neovim without having to rebuild
  # path is absolute; will need to change if you are stealing this module for yourself
  #xdg.configFile."nvim".source =
  #  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles-2.0/modules/home/neovim/config";

  #home.file.".config/nvim" = {
  #  source = ./config;
  #  recursive = true;
  #};

  # lsp binaries and toolchains go here, actual configuration lives in neovims native config structure
  home.packages = with pkgs; [
    go-grip
    neovim
    lazygit
    fzf
    ripgrep
    fd

    rustup

    lua-language-server
    stylua

    typescript
    typescript-language-server
    prettier

    nil
    nixfmt
    alejandra

    harper

    gopls
    go

    bun
  ];
}
