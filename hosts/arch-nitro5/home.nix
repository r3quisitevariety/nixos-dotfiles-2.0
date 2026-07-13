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
    # TODO lots of this tooling could go in a platform agnostic module. maybe neovim.nix can be turned into tooling.nix
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
