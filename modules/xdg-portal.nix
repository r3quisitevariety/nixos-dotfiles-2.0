{pkgs, ...}: {
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  home.packages = with pkgs; [
    # installed imperatively (nix install breaks portals)
    #xdg-desktop-portal-hyprland
    #xdg-desktop-portal-kde
    #xdg-desktop-portal-gtk
  ];

  # hyprland;gtk is NEEDED otherwise obs or other apps for streaming like discord won't work
  # gtk is superior anyways; im starting to loathe kde
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
  '';

  xdg.mime.enable = true; # allows installed apps to show in path
}
