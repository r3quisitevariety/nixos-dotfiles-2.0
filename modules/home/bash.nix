{...}: {
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
      notes = "cd ~/Documents/obsidian && nvim";
    };
    bashrcExtra = "
      PS1='\\[\\e[1;32m\\]\\u@\\h\\[\\e[0m\\]:\\[\\e[1;34m\\]\\w\\[\\e[0m\\]\\$ '
    ";
  };
  home.sessionVariables = {
    VISUAL = "vim";
    EDITOR = "vim";
  };
}
