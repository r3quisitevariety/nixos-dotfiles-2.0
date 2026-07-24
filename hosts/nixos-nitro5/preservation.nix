{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos"
        "/var/log"
        "/etc/NetworkManager/system-connections"
        "/tmp"
      ];

      users.nix = {
        files = [];
        directories = [
          "Downloads"
          "Games"
          "code"
          "Documents"
          "Videos"
          "Pictures"
          "nixos-dotfiles-2.0"
          ".local/state/noctalia"
          ".config/nvim"
        ];
      };
    };
  };
}
