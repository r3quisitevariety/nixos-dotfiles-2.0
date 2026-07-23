{
  pkgs,
  config,
  lib,
  ...
}: {
  # an issue i have with this is i might want proton-vpn-cli as an "app" on my server, but i do not want other apps like obsidian/steam; using conditional logic would solve this; i dont need fp/import-tree. just something simpler and built in
  home.packages = with pkgs; [
    mpv
    steam
    vesktop
    reaper
    kdenlive
    prismlauncher
    krita
    anki
    wayvr
    #zen-browser

    proton-vpn-cli
  ];
}
