{
  config,
  pkgs,
  ...
}: {
  #TODO - wrap neovim fully in nix, including config

  # puts files from ./config in ~/.config/nvim
  xdg.configFile."nvim".source =
    #config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/neovim-dots";
    config.lib.file.mkOutOfStoreSymlink "./config";

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
