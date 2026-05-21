{
  pkgs,
  config,
  ...
}: {
  # ccache skips already compiled objects
  # TODO - enforce the ccache overlay with kobold
  #  programs.ccache.enable = true;
  #  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
  #  programs.ccache.packageNames = [ "koboldcpp" ];
  #
  #  nixpkgs.overlays = [
  #    (self: super: {
  #      ccacheWrapper = super.ccacheWrapper.override {
  #        extraConfig = ''
  #          export CCACHE_COMPRESS=1
  #          export CCACHE_DIR="${config.programs.ccache.cacheDir}"
  #          export CCACHE_UMASK=007
  #          export CCACHE_SLOPPINESS=random_seed
  #          if [ ! -d "$CCACHE_DIR" ]; then
  #            echo "====="
  #            echo "Directory '$CCACHE_DIR' does not exist"
  #            echo "Please create it with:"
  #            echo "  sudo mkdir -m0770 '$CCACHE_DIR'"
  #            echo "  sudo chown root:nixbld '$CCACHE_DIR'"
  #            echo "====="
  #            exit 1
  #          fi
  #          if [ ! -w "$CCACHE_DIR" ]; then
  #            echo "====="
  #            echo "Directory '$CCACHE_DIR' is not accessible for user $(whoami)"
  #            echo "Please verify its access permissions"
  #            echo "====="
  #            exit 1
  #          fi
  #        '';
  #      };
  #    })
  #  ];

  environment.systemPackages = with pkgs; [
    #    lmstudio
    #ollama-cuda
    #(pkgs.koboldcpp.override { config.cudaSupport = true; }) # very resource intensive build
    # might just use kobold with source pinned recent versions because it moves too fast.
    # maybe version 1.11 wil fix my cuMemCreate error, we'll see once it passes
    # currently using shell.nix for kobold because of weird cuda related issues.
    sillytavern # currently installed imperatively, might declare it if I feel like it
    aichat
  ];

  #ollama suckzzz, kobold better (just using for embed text ig)
  #  services.ollama = {
  #    enable = true;
  #    package = pkgs.ollama-cuda;
  #    host = "127.0.0.1";
  #    loadModels = [
  #      # weird, doesnt work, looks like u gotta do it imperatively still
  #      #"gemma4:e4b"
  #      #"nomic-embed-text-v2-moe:latest"
  #    ];
  #  };
  #
  #  services.sillytavern = {
  #    enable = true;
  #    port = 8000;
  #    listen = true;
  #    listenAddressIPv4 = "0.0.0.0"; # Listens on all interfaces (safest for LAN)
  #  };

  environment.shellAliases = {
    ai = "aichat --session --role concise";
  };
}
