{
  pkgs,
  config,
  ...
}: {
  programs.rmpc = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      rmpc = "rmpc update && rmpc"; ## updates mpd database every time rmpc is run
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music/keepers";
    playlistDirectory = "${config.home.homeDirectory}/Music/keepers";

    extraConfig = ''
      audio_output {
        type    "pipewire"
        name    "MPD PipeWire"
        mixer_type "software"
      }
    '';
  };

  services.mpd-mpris.enable = true;
  home.packages = [pkgs.playerctl];
}
