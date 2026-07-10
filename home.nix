{
  config,
  pkgs,
  ...
}: {
  # paru
  # lix/nix
  # hyprscroll

  #  programs.firefox = {
  #    enable = true;
  #    profiles.myprofile.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
  #      ublock-origin
  #      bitwarden
  #      darkreader
  #      vimium
  #    ];
  #  };

  services.syncthing = {
    enable = true;
    # rest is done imperatively
  };
  #services.tailscale.enable = true; — this is done imperatively

  nixpkgs.config.allowUnfree = true;

  home.username = "bean";
  home.homeDirectory = "/home/bean";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nh
    microfetch
    #mpv
    #obsidian - seems like anything that needs to be in your path should just be installed manually.
    #pywalfox-native
    #obs studio
    #steam - installed imperatively
    # wivrn, xrizer — installed imperatively
    # discord — installed imperatively
  ];

  # we will want tree-import or whatever the fuck stella uses - implement; TODO
  imports = [
    ./modules/tmux.nix
    ./modules/music.nix
    ./modules/neovim.nix
    ./modules/xdg-portal.nix
  ];
}
