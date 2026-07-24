{...}: {
  imports = [
    # home.nix is imported through flake
    ./configuration.nix
    ../../modules/nixos/noctalia-greeter.nix
    ../../modules/nixos/vr.nix
    #./hardware-configuration.nix
    #./substituters.nix
  ];
}
