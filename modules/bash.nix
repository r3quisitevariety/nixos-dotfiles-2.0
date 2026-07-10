{...}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      neofetch = "fastfetch";
      v = "nvim";
      g = "git";
    };
    bashrcExtra = "
      PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
    ";
  };
}
