{
  config,
  pkgs,
  ...
}: {
  # TODO slowly wane off ubuntu's imperative management and declare things like syncthing; server will be NixOS managed in the future.

  nixpkgs.config.allowUnfree = true;

  home.username = "black";
  home.homeDirectory = "/home/black";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    # TODO lots of packages here are worth turning into modules instead.

    #proton-vpn-cli <-- conflicts with weird imperative installation - using nix-shell -p instead
  ];

  imports = [
    ../../modules/home/neovim.nix
    ../../modules/home/vim.nix
    ../../modules/home/tmux.nix
    # rebuild will fail if you dont remove .bashrc + bash_profile on host
    ../../modules/home/shell.nix
  ];
}
