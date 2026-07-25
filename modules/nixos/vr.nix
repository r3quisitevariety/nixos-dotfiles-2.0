{
  pkgs,
  config,
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
    package = pkgs.wivrn.override {cudaSupport = true;};
  };

  networking.firewall.allowedTCPPorts = [
    9757
  ];

  networking.firewall.allowedUDPPorts = [
    9757
  ];

  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
}
