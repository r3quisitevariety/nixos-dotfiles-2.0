{...}: {
  home.username = "requisite";
  home.homeDirectory = "/home/requisite";
  home.stateVersion = "25.11";

  imports = [
    # TODO i commented these out because i have yet to resolve hostname hardcoding for modules
    #../../modules/neovim.nix
    #../../modules/vr.nix
    #../../modules/obs.nix
    #../../modules/substituters.nix
    #../../modules/noctalia-greeter.nix
  ];
}
