{
  config,
  pkgs,
  ...
}: {
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

  home.username = "makoro";
  home.homeDirectory = "/home/makoro";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nh
    microfetch
    obsidian
    #pywalfox-native
    #obs studio
    #steam - installed imperatively
    # wivrn, xrizer — installed imperatively
    # discord — installed imperatively
  ];

  imports = [
    ./modules/music.nix
    ./modules/neovim.nix
    ./modules/xdg-portal.nix
  ];
}
