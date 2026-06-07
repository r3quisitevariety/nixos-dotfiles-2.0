{
  config,
  pkgs,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = "requisite";
  home.homeDirectory = "/home/requisite";
  home.stateVersion = "25.11"; # just added this lol, idk if its sufficient

  imports = [
    ./home/music.nix
  ];
}
