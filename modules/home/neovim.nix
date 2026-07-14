{
  config,
  pkgs,
  ...
}: {
  #TODO - wrap neovim fully in nix, including config

  # lsp binaries and toolchains go here, actual configuration lives in neovims native config structure
  home.packages = with pkgs; [
    go-grip # for previewing README's before push
    neovim
    lazygit
    #fzf
    #ripgrep
    #fd

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
