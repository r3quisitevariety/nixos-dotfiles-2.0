{...}: {
  imports = [
    # home.nix is imported through flake
    ./configuration.nix
    ./hardware-configuration.nix
    ./substituters.nix
  ];
}
