# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').
{ config, pkgs, inputs, ... }:

# allows unstable packages to be installed prefixed with unstable.<pkgname>
#let
#  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
#    config.allowUnfree = true;
#  };
#in

{

  # ── Compositors ─────────────────────────────────────────────────────────────
  programs.hyprland.enable = true;
  programs.niri.enable     = true;
  programs.mangowc.enable  = true;

  # disable coredumps so the jet engine doesn't spin up when switching wm/de
  systemd.coredump.enable              = false;
  boot.kernel.sysctl."kernel.core_pattern" = "/dev/null";

  # ── Imports ─────────────────────────────────────────────────────────────────
  imports = [ ./hardware-configuration.nix ];


  # ── Nix / Flakes ────────────────────────────────────────────────────────────
  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # automatic system upgrades (disabled)
  #system.autoUpgrade = {
  #  enable            = true;
  #  persistent        = true;       # catches missed runs on boot
  #  dates             = "Sun 02:00";
  #  randomizedDelaySec = "45min";
  #  allowReboot       = false;      # no auto-reboot (safer for laptop)
  #};

  # automated garbage collection (disabled)
  #nix.gc = {
  #  automatic = true;
  #  dates     = "weekly";
  #  options   = "--delete-older-than 30d";
  #};


  # ── Boot ────────────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable    = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "acpi_backlight=native" ]; # fix backlight


  # ── Networking ──────────────────────────────────────────────────────────────
  networking.hostName = "variety";
  # networking.wireless.enable = true;  # wpa_supplicant
  # networking.proxy.default  = "http://user:password@proxy:port/";
  # networking.proxy.noProxy  = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;  # fixes wifi not working from waking suspend
  };
  networking.firewall.allowedTCPPorts = [ 8384 3923 ]; #syncthing, copyparty
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;


  # ── Locale / Time ───────────────────────────────────────────────────────────
  time.timeZone      = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
    "ko_KR.UTF-8/UTF-8"
  ];

  # ── Input Methods (CJK IME) ──────────────────────────────────────────────────
# will possibly enable in the future when needed
# i18n.inputMethod = {
#   enable = true;
#   type   = "fcitx5";
#   fcitx5.addons = with pkgs; [
#     fcitx5-mozc      # japanese
#     fcitx5-chinese-addons  # chinese (pinyin etc)
#     fcitx5-hangul    # korean
#     fcitx5-gtk       # gtk integration
#   ];
# };

  # ── Display / Desktop ───────────────────────────────────────────────────────
  services.xserver.enable = true;
  services.libinput.enable = true;

  # KDE Plasma 6
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = { # disabled in favor of tuigreet/greetd - experiencing sddm crashes, probably due to NVIDIA quirks.
    enable         = false;
    wayland.enable = true; # experimental
  };

  # GNOME
  services.desktopManager.gnome.enable = true;
  #services.displayManager.gdm.enable = true;

  # greetd + tuigreet (active display manager)
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = ''
        ${pkgs.tuigreet}/bin/tuigreet \
          --time \
          --remember \
          --remember-session \
          --cmd mango
      '';
      user = "requisite";
    };
  };

  # seatd: fixes greetd touchpad issues on mangowc
  services.seatd.enable = true;

  # use KDE's ksshaskpass for keyring auth on both DEs
  programs.ssh.askPassword =
    pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

  services.xserver.xkb = {
    layout  = "us";
    variant = "";
    #options = "caps:escape"; # bind caps to escape (using keyd instead)
  };

  # rebind caps → escape at the kernel level via keyd
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.main.capslock = "escape";
    };
  };


  # ── Hardware ────────────────────────────────────────────────────────────────
  hardware.graphics.enable = true;

  # NVIDIA PRIME offload (Acer Nitro 5, RTX 4060)
  hardware.nvidia = {
    open              = false;
    modesetting.enable   = true;
    powerManagement.enable = true;
    nvidiaSettings    = true;
    package           = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      intelBusId  = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
      offload = {
        enable           = true;
        enableOffloadCmd = true; # use `nvidia-offload <cmd>` to explicitly invoke dGPU
      };
    };
  };

  # modesetting driver so xserver doesn't hog the GPU in the background
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.bluetooth = {
    enable       = true;
    powerOnBoot  = true;
    settings = {
      General = {
        ControllerMode  = "dual";
        Experimental    = true;
        FastConnectable = true;
      };
      Policy.AutoEnable = true;
    };
  };

  services.power-profiles-daemon.enable = true; #switch between performance, balance, or battery saving
  services.upower.enable = true; 


  # ── Audio ───────────────────────────────────────────────────────────────────
  services.pulseaudio.enable = false;
  security.rtkit.enable      = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
    #jack.enable      = true;
    #media-session.enable = true;
  };


  # ── Users ───────────────────────────────────────────────────────────────────
  users.users.requisite = {
    isNormalUser = true;
    description  = "rqvrty";
    extraGroups  = [ "networkmanager" "wheel" "seat" "input" "video" ];
    packages     = with pkgs; [
      prometheus-nvidia-gpu-exporter
      #thunderbird
    ];
  };

  # sail the seven seas
  users.users.guest = {
    isNormalUser = true;
    extraGroups  = [ "wheel" "video" "audio" "games" ];
    packages     = [ pkgs.steam ];
    password     = "temp123";
  };


  # ── Programs ────────────────────────────────────────────────────────────────
  programs.firefox.enable  = true;
  programs.chromium.enable = true;
  programs.steam.enable    = true;
  programs.nix-ld.enable   = true; # FHS compat fixes
  programs.pay-respects.enable = true; #press F to pay respects

  programs.vim = {
    enable        = true;
    defaultEditor = false;
    package = pkgs.vim-full.customize {
      name = "vim";
      vimrcConfig.customRC = ''
        set clipboard=unnamedplus
        set number
        set relativenumber
        set tabstop=2
        set shiftwidth=2
        set expandtab
        set wrap
        set linebreak
        set smartindent
        syntax on
        nnoremap <leader>w :set wrap!<CR>
      '';
    };
  };

  programs.nano.enable = false;

  programs.tmux = {
    enable       = true;
    shortcut     = "b";
    escapeTime   = 0;
    historyLimit = 10000;
    extraConfig  = ''
      # pane navigation (hjkl)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # pane resizing (HJKL)
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # splits that open in current directory
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      #set -g mouse on
    '';
  };

  # auto tmux attach on shell start (disabled)
  #programs.bash.interactiveShellInit = ''
  #  if [[ -z "$TMUX" && $- == *i* ]]; then
  #    exec tmux new-session -A -s default
  #  fi
  #'';


  # yazi: cd into cwd on quit
  programs.bash.interactiveShellInit = ''
    function ya() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      yazi "$@" --cwd-file="$tmp"
      if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
      fi
      rm -f -- "$tmp"
    }

    eval "$(pay-respects bash --alias)"  # press F to pay respects (thefuck alternative)

  '';


  # ── Environment ─────────────────────────────────────────────────────────────
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  environment.shellAliases = {
    neofetch = "fastfetch";
    "67"     = "sudo nixos-rebuild switch";
    cp       = "cp -r";
    edit     = "sudo vim /etc/nixos/configuration.nix";
    v        = "nvim";
    g        = "git";
  };


  # ── Packages ────────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [

    # ── Wayland / Compositor ──────────────────────────────────────────────────
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ghostty fuzzel foot
    wlr-randr xwayland-satellite   # monitor detection; niri xwayland support
    hyprshot cliphist              # screenshot; clipboard (niri)
    kdePackages.qt6ct pywalfox-native
    jq                             # youtube music plugin
    udiskie
    evtest                         # for bongo cat plugin :3

    # mangowc image-toolkit plugin deps
    grim slurp wl-clipboard
    tesseract imagemagick zbar     #curl
    translate-shell wf-recorder   #ffmpeg
    gifski

    # ── Bitwig (XCB deps) ─────────────────────────────────────────────────────
    libxcb xcbutil xcbutilwm
    xcbutilkeysyms xcbutilrenderutil xcbutilimage

    # ── Build tools ───────────────────────────────────────────────────────────
    gcc gnumake cmake binutils cfssl

    # ── CLI utilities ─────────────────────────────────────────────────────────
    git fzf ripgrep fd yazi tree
    wget tldr fastfetch microfetch
    ffmpeg yt-dlp streamlink rclone
    btop htop w3m python3

    # ── Dev / editors ─────────────────────────────────────────────────────────
    zed-editor vscode obsidian
    opencode yarn zola gh-dash gh
    nb                             #unstable.nb

    # ── Desktop apps ──────────────────────────────────────────────────────────
    mpv obs-studio ani-cli
    vesktop anki-bin heroic
    google-chrome zoom-us qbittorrent
    proton-vpn                     #protonvpn-gui
    copyparty unar
    mesa-demos nvtopPackages.nvidia
    nh
                                   #unstable.newsraft

    # ── GNOME extensions ──────────────────────────────────────────────────────
    gnomeExtensions.tiling-shell
    gnomeExtensions.pop-shell
    gnomeExtensions.paperwm

  ];


  # ── Fonts ───────────────────────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif  # optional, for serif contexts
  ];


  # ── Services ────────────────────────────────────────────────────────────────
  services.printing.enable = true;
  services.openssh.enable  = true;
  services.flatpak.enable  = true;
  

  services.syncthing = {
    enable           = true;
    openDefaultPorts = true; # does NOT open the GUI port
    user             = "requisite";
    configDir        = "/home/requisite/.config/syncthing";
  };

  services.tailscale = {
    enable = true;
    #authKeyFile = "/run/secrets/tailscale_key";
  };

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable         = true;
  #   enableSSHSupport = true;
  # };


  # ── Swap ────────────────────────────────────────────────────────────────────
  swapDevices = [{
    device = "/swapfile";
    size   = 8192; # 8GB
  }];


  # ── Invidious (disabled) ────────────────────────────────────────────────────
  #services.invidious = {
  #  enable = true;
  #  port   = 8090;
  #  settings = {
  #    invidious_companion = [{ private_url = "http://localhost:8282/companion"; }];
  #    invidious_companion_key = "Uxep6ohv7sungie7"; # generate securely
  #    default_user_preferences = {
  #      related_videos = false;
  #      comments       = [];
  #    };
  #  };
  #};

  # docker container for invidious-companion (disabled)
  #virtualisation.docker.enable = true;
  #virtualisation.oci-containers = {
  #  backend = "docker";
  #  containers.invidious-companion = {
  #    image   = "quay.io/invidious/invidious-companion:latest";
  #    ports   = [ "127.0.0.1:8282:8282" ];
  #    volumes = [ "companioncache:/var/tmp/youtubei.js:rw" ];
  #    environment.SERVER_SECRET_KEY = "Uxep6ohv7sungie7"; # match above
  #  };
  #};


  system.stateVersion = "25.11"; # did you read the comment?

}
