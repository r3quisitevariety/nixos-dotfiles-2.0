{ config, pkgs, ... }:

{

  # i currently have a normie neovim config in ~/.config/nvim and this module is here to manage the deps, though i do plan to make a nix wrapper soon for my entire neovim config
  environment.systemPackages = with pkgs; [
    neovim
    lazygit
    #fzf
    #ripgrep
    #fd

    rustup # includes rustfmt for conform
    rust-analyzer

    lua-language-server
    stylua

    typescript
    typescript-language-server

    #nixd
    nil # Nix LSP
    nixfmt

    harper

    # Add more as needed
  ];

}
