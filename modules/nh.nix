{
  config,
  pkgs,
  ...
  # nh package is in configuration.nix
}: {
  programs.nh = {
    enable = true;
    #clean.enable = true;
    #clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/makoro/nixos-dotfiles"; # sets NH_OS_FLAKE variable for you
  };
}
