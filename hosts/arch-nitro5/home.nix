{
  config,
  pkgs,
  ...
}: {
  services.syncthing = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.username = "bean";
  home.homeDirectory = "/home/bean";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    proton-vpn
    opencode
    nh
    microfetch
    unar
    fzf
    btop
    ripgrep
    fd
    bat
    eza
    tree
    tldr
    curl
    wget
    yt-dlp
    home-manager
    #mpv
    #obsidian
    #pywalfox-native
    #obs-studio
    #steam
    #wivrn
    #xrizer
    #discord
    #tailscale
    #paru
    #lix/nix
    #hyprscroll
  ];

  imports = [
    ../../modules/vim.nix
    ../../modules/tmux.nix
    ../../modules/music.nix
    ../../modules/neovim.nix
    ../../modules/xdg-portal.nix
    ../../modules/bash.nix
  ];
}
