{
  pkgs,
  config,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    xrizer
    opencomposite
    wayvr
  ];

  services.wivrn = {
    enable = true;
    openFirewall = true;
    # Run WiVRn as a systemd service on startup
    autoStart = true;
    #package = (pkgs.wivrn.override { cudaSupport = true; });
    #package = inputs.wivrn.packages.${pkgs.stdenv.hostPlatform.system}.default.override {cudaSupport = true;};
    package = inputs.wivrn.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
