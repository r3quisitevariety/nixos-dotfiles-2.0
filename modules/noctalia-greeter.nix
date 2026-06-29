{
  inputs,
  pkgs,
  ...
}: {
  # greetd configuration exists in configuration.nix

  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Optional configuration
    greeter-args = "";
    settings = {
      cursor = {
        theme = "Breeze";
        size = 20;
      };
      keyboard = {
        layout = "us";
      };
    };
  };
}
