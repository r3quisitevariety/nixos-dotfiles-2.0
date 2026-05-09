{ pkgs, config, ... }:

{

  environment.systemPackages = with pkgs; [
    emacs
    clang
    libtool # for vterm
    #rg
    #fd
    #git
  ];

}
