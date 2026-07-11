{
  config,
  pkgs,
  ...
}: {
  # paru
  # lix/nix
  # hyprscroll

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
    vim
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
  ];

  # we will want tree-import or whatever the fuck stella uses - implement; TODO
  imports = [
    ./modules/tmux.nix
    ./modules/music.nix
    ./modules/neovim.nix
    ./modules/xdg-portal.nix
    ./modules/bash.nix
  ];
}
