{ inputs, pkgs, ... }:

#let
#  nixpkgs-unstable = import inputs.nixpkgs-unstable {
#    system = pkgs.stdenv.hostPlatform.system;
#    config.allowUnfree = true;
#  };
#in
{
  environment.systemPackages = with pkgs; [
    lmstudio
    #ollama-cuda # very resource intensive build
    koboldcpp
    sillytavern
  ];
}
