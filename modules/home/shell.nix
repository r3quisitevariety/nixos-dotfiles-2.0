{pkgs, ...}: {
  nix.package = pkgs.lixPackageSets.stable.lix;
  # make sure .bashrc and bash_profile are removed locally, otherwise home manager will give you an error as it does not want to delete the files.
  programs.bash = {
    enable = true;
    shellAliases = {
      neofetch = "fastfetch";
      v = "nvim";
      g = "git";
      cp = "cp -r";
      ls = "eza --color=auto";
      grep = "grep --color=auto";
      yay = "paru";
      notes = "cd ~/Documents/masterplan && nvim";
    };
    bashrcExtra = "
      PS1='\\[\\e[1;32m\\]\\u@\\h\\[\\e[0m\\]:\\[\\e[1;34m\\]\\w\\[\\e[0m\\]\\$ '
    ";
  };
  home.sessionVariables = {
    VISUAL = "vim";
    EDITOR = "vim";
  };

  home.packages = with pkgs; [
    ranger
    opencode
    htop
    btop
    proton-vpn
    nh
    microfetch
    unar
    fzf
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
    zola
  ];
}
