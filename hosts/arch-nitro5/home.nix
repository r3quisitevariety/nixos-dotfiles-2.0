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

  home.file.".config/hypr/hyprland.lua" = {
    source = ../../normie-dots/hyprland.lua;
  };

  home.file.".config/foot/foot.ini" = {
    source = ../../normie-dots/foot.ini;
  };

  home.file.".local/state/noctalia/settings.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-dotfiles-2.0/normie-dots/settings.toml";

  home.packages = with pkgs; [
    # probably want to put this stuff in a pacman script
    fuzzel
    foot
    #mpv
    #obsidian
    #pywalfox-native
    #obs-studio
    #steam
    #
    #wivrn-dashboard
    #wivrn-server
    #xrizer
    #
    #discord
    #tailscale
    #paru
    #lix/nix
    #hyprscroll
    #reaper
    #kdenlive

    # noctalia
    # gwenview
    # kdeconnect
    # zen-browser-bin
    # prismlauncher
    # krita
  ];

  imports = [
    ../../modules/home/vim.nix
    ../../modules/home/tmux.nix
    ../../modules/home/music.nix
    ../../modules/home/neovim.nix
    ../../modules/home/xdg-portal.nix
    ../../modules/home/bash.nix
  ];
}
