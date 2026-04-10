{ inputs, pkgs, ... }:

let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    nixpkgs-unstable.lmstudio
    ollama-cuda # very resource intensive build
    nixpkgs-unstable.koboldcpp
    nixpkgs-unstable.sillytavern
  ];
}
