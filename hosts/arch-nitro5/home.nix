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
    fuzzel
    foot
    nautilus
    # install imperatively like the normie that you are
    #paru
    # lix/nix
    # noctalia
    # noctalia-greeter
    # zen-browser-bin
    # discord
    # steam
    # obsidian
    # wivrn-dashboard
    # wivrn-server
    # xrizer
    # gwenview
    # mpv
    # obs-studio
    # tailscale
    # reaper
    # kdenlive
    # kdeconnect
    # prismlauncher
    # krita
  ];

  imports = [
    ../../modules/home/music.nix
    ../../modules/home/neovim.nix
    ../../modules/system/xdg-portal.nix
    ../../modules/home/shell.nix
  ];
}
