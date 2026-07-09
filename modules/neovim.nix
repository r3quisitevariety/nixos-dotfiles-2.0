{
  config,
  pkgs,
  ...
}: {
  # lsp binaries and toolchains go here, actual configuration lives in neovims native config structure
  home.packages = with pkgs; [
    neovim
    lazygit
    #fzf
    #ripgrep
    #fd

    rustup # includes rustfmt for conform
    #rust-analyzer

    lua-language-server
    stylua

    typescript
    typescript-language-server
    prettier

    nil # Nix LSP
    nixfmt
    alejandra

    harper

    gopls
    go

    bun
  ];
}
