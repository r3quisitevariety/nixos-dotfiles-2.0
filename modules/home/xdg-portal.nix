{pkgs, ...}: {
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  # TODO wrap imperative stuff in nix modules and scripts
  home.packages = with pkgs; [
    # installed imperatively (nix install breaks portals)
    #xdg-desktop-portal-hyprland
    #xdg-desktop-portal-kde
    #xdg-desktop-portal-gtk
    #nwg-look adw-gtk-theme
    #qt6ct-kde
  ];

  # hyprland;gtk is NEEDED otherwise obs or other apps for streaming like discord won't work
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
  '';

  xdg.mime.enable = true; # allows installed apps to show in path
}
