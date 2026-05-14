{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [
    xrizer
    opencomposite
  ];

  services.wivrn = {
    enable = true;
    openFirewall = true;
    # Run WiVRn as a systemd service on startup
    autoStart = true;
    package = (pkgs.wivrn.override { cudaSupport = true; });
  };
}
