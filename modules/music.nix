{pkgs, ...}: {
  programs.rmpc.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "/home/makoro/Music/h2";

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
