{
  config,
  pkgs,
  ...
}: {
  # TODO slowly wane off ubuntu's imperative management and declare things like syncthing; server will be NixOS managed in the future.

  services.git-sync = {
    enable = true;
    repositories = {
      nixos-dotfiles = {
        path = "${config.home.homeDirectory}/home/black/nixos-dotfiles-2.0";
        uri = "git@github.com:r3quisitevariety/nixos-dotfiles-2.0.git";
        interval = 1000;
      };
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.username = "black";
  home.homeDirectory = "/home/black";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # TODO lots of packages here are worth turning into modules instead.

    #proton-vpn-cli <-- conflicts with weird imperative installation - using nix-shell -p instead
    opencode
    nh
    microfetch
    unar
    fzf
    btop
    ripgrep
    fd
    bat
    eza
    tree
    tldr
    curl
    wget
    yt-dlp
    home-manager
  ];

  imports = [
    ../../modules/neovim.nix
    ../../modules/vim.nix
    ../../modules/tmux.nix
    # rebuild will fail if you dont remove .bashrc + bash_profile on host
    ../../modules/bash.nix
  ];
}
