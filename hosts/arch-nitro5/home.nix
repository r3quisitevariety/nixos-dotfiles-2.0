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
    force = true;
  };

  home.file.".config/foot/foot.ini" = {
    source = ../../normie-dots/foot.ini;
    force = true;
  };

  home.file.".local/state/noctalia/settings.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/nixos-dotfiles-2.0/normie-dots/settings.toml";

  home.packages = with pkgs; [
    # probably want to put this stuff in a pacman script

    # noctalia
    # noctalia-greeter
    # zen-browser-bin
    # discord
    # steam
    # obsidian
    fuzzel
    foot
    # wivrn-dashboard
    # wivrn-server
    # xrizer
    #
    # nautilus
    # gwenview
    #
    # mpv
    # obs-studio
    #
    # tailscale
    # paru
    # lix/nix
    #
    # reaper
    # kdenlive
    # kdeconnect
    # prismlauncher
    # krita
  ];

  imports = [
    ../../modules/home/music.nix
    ../../modules/home/neovim.nix
    ../../modules/home/xdg-portal.nix
    ../../modules/home/shell.nix
  ];
}
