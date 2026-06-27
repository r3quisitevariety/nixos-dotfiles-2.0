{
  config,
  pkgs,
  inputs,
  ...
}: {
  # ── Compositors ─────────────────────────────────────────────────────────────
  programs.hyprland.enable = true;
  programs.niri.enable = true;

  # disable coredumps so no jet engine laptop when switching wm's
  systemd.coredump.enable = false;
  boot.kernel.sysctl."kernel.core_pattern" = "/dev/null";

  # ── Imports ─────────────────────────────────────────────────────────────────
  imports = [./hardware-configuration.nix];

  # ── Nix / Flakes ────────────────────────────────────────────────────────────
  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 2;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = ["acpi_backlight=native"]; # fix backlight

  # ── Networking ──────────────────────────────────────────────────────────────
  networking.hostName = "variety";
  # networking.wireless.enable = true;  # wpa_supplicant
  # networking.proxy.default  = "http://user:password@proxy:port/";
  # networking.proxy.noProxy  = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false; # fixes wifi not working from waking suspend
  };
  networking.firewall.allowedTCPPorts = [
    8384
    3923
    8000
    5001 # kobold
    9757 # wivrn
  ]; # syncthing, copyparty
  networking.firewall.allowedUDPPorts = [
    9757 #wivrn
    5353 #avahi
  ];

  # ── Locale / Time ───────────────────────────────────────────────────────────
  time.timeZone = "America/New_York";
  #time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
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

  xdg.portal = {
    # fixes file picker issues
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      #pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    config.common = {
      default = "hyprland;kde";
      "org.freedesktop.impl.portal.FileChooser" = "kde";
      "org.freedesktop.impl.portal.Secret" = "kwallet";
      "org.freedesktop.impl.portal.Settings" = "kde"; # for calendar
    };
  };

  # KDE Plasma 6
  services.desktopManager.plasma6.enable = true; # gives xdg portal, elisa, dolphin, cursor, ui niceties, etc.

  # GNOME
  services.desktopManager.gnome.enable = true; # enabled for fallback + compatibility

  # greetd + tuigreet (active display manager)
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd start-hyprland";
      user = "requisite";
    };
  };

  # seatd: fixes greetd touchpad issues on mangowc
  services.seatd.enable = true;

  # use KDE's ksshaskpass for keyring auth on both DEs
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # rebind caps → escape at the kernel level via keyd
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings.main.capslock = "escape";
    };
  };

  # ── Hardware ────────────────────────────────────────────────────────────────
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # NVIDIA PRIME offload (Acer Nitro 5, RTX 4060)
  hardware.nvidia = {
    open = false;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true; # use `nvidia-offload <cmd>` to explicitly invoke dGPU
      };
    };
  };

  # modesetting driver so xserver doesn't hog the GPU in the background
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "dual";
        Experimental = true;
        FastConnectable = true;
      };
      Policy.AutoEnable = true;
    };
  };

  services.power-profiles-daemon.enable = true; # switch between performance, balance, or battery saving
  services.upower.enable = true;

  # ── Audio ───────────────────────────────────────────────────────────────────
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable      = true;
    #media-session.enable = true;
  };

  # ── Users ───────────────────────────────────────────────────────────────────
  users.users.requisite = {
    isNormalUser = true;
    description = "rqvrty";
    extraGroups = [
      "networkmanager"
      "wheel"
      "seat"
      "input"
      "video"
    ];
    packages = with pkgs; [
      prometheus-nvidia-gpu-exporter
    ];
  };

  # ── Programs ────────────────────────────────────────────────────────────────
  programs.firefox = {
    enable = true;
  };
  programs.chromium.enable = true;
  programs.steam = {
    enable = true;
  };
  programs.nix-ld.enable = true; # FHS compat fixes
  programs.pay-respects.enable = true; # press F to pay respects

  programs.vim = {
    enable = true;
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
    enable = true;
    shortcut = "b";
    escapeTime = 0;
    historyLimit = 10000;
    extraConfig = ''
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

      set -g mouse on
      set -g set-clipboard on
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
    '';
  };

  # bashrc
  programs.bash.interactiveShellInit = ''
      function ya() { # yazi: cd into cwd on quit
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      eval "$(pay-respects bash --alias)"  # press F to pay respects (thefuck alternative)

    #if [[ $SHLVL == 1 ]]; then
    #  fortune | ${pkgs.kittysay}/bin/kittysay
    #fi

      export PATH="$HOME/.emacs.d/bin:$PATH"
  '';

  # ── Environment ─────────────────────────────────────────────────────────────
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  # aliases
  environment.shellAliases = {
    neofetch = "fastfetch";
    notes = "cd ~/Documents/obsidian && nvim";
    "67" = "sudo nixos-rebuild switch";
    cp = "cp -r";
    edit = "sudo vim /etc/nixos/configuration.nix";
    v = "nvim";
    g = "git";
    #rm = ''echo "this is not the command you are looking for."; false'';
  };

  # ── Packages ────────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # ── Wayland / Compositor ──────────────────────────────────────────────────
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    gpu-screen-recorder
    fuzzel
    foot
    wlr-randr
    xwayland-satellite # for niri
    kdePackages.qt6ct
    nwg-look # for gtk theming
    pywalfox-native
    jq # youtube music plugin
    udiskie
    evtest # for bongo cat plugin :3
    nvtopPackages.nvidia # nvidia stuff
    # mangowc image-toolkit plugin deps
    wl-clipboard
    (tesseract.override {enableLanguages = ["eng"];})
    imagemagick
    zbar # curl
    translate-shell
    wf-recorder # ffmpeg
    gifski

    # ── Build tools ───────────────────────────────────────────────────────────
    gcc
    gnumake
    cmake
    binutils
    cfssl
    yarn

    # ── CLI utilities ─────────────────────────────────────────────────────────
    trash-cli
    tokei

    kittysay
    fortune
    lolcat

    git
    fzf
    ripgrep
    fd
    go-grip
    yazi
    tree
    wget
    curl
    tldr
    fastfetch
    microfetch
    macchina
    hyfetch
    ffmpeg
    yt-dlp
    rclone
    btop
    htop
    w3m
    python3

    # ── Dev / editors ─────────────────────────────────────────────────────────
    vscode
    obsidian
    opencode
    zola

    # ── Apps ──────────────────────────────────────────────────────────────────
    telegram-desktop
    reaper
    picard
    nicotine-plus
    kdePackages.kdenlive
    p7zip
    unityhub
    alcom
    lutgen
    lutgen-studio
    affine
    moonlight-qt
    mpv
    qdirstat
    ani-cli
    vesktop
    anki-bin
    heroic
    google-chrome
    zoom-us
    qbittorrent
    proton-vpn
    proton-vpn-cli
    protonup-qt
    unar
    nh
  ];

  # ── Fonts ───────────────────────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif # optional, for serif contexts
  ];

  # ── Services ────────────────────────────────────────────────────────────────
  services.printing.enable = true;
  services.openssh.enable = false; # remove giant attack surface
  services.flatpak.enable = true;

  services.syncthing = {
    enable = true;
    openDefaultPorts = true; # does NOT open the GUI port
    user = "requisite";
    configDir = "/home/requisite/.config/syncthing";
  };

  services.tailscale = {
    enable = true;
    #authKeyFile = "/run/secrets/tailscale_key";
  };

  # ── Swap ────────────────────────────────────────────────────────────────────
  swapDevices = [
    {
      device = "/swapfile";
      size = 8192;
    }
  ];

  #  virtualisation.docker = {
  #    enable = true;
  #  };

  system.stateVersion = "25.11"; # did you read the comment?
}
