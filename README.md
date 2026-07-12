**update:** i switched to cachyos/arch and im currently in the process of migration; expect major rewrites to the config. this will be a great learning opportunity for me to deepen my nix knowledge.

---

my design choices are idiomatic with the (current) nixos ecosystem, prioritizing general compatibility with existing documentation (sorry, no dendritic here!). this has resulted in me adopting flakes + home manager and keeping a pretty sane file structure. 

I am well aware that there are others who would see this design choice as bloat, however it isn't really important to me as my stylistic choice prioritizes ergonomics and ease of use. I am still *for* learning the nix module system as there are some things that are just truly ineffective with home-manager. despite that though, I think home-manager is a valuable tool, albeit somewhat headstrong and brute.

I pretty much started off with flakes and so they are familiar to me. I might try out alternatives in the future, but I currently have no issues with them; I am aware that they are in a kind of weird spot development-wise though.

I have dotfiles I manually copied from ~/.config into normie-dots/; ill symlink them once I understand the nix module system; some things I prefer to manage via native config syntax (hyprland, neovim) rather than using nix, as it is more ergonomic and compatible with existing documentation.

### overview 
- at the top level, we have the flake.nix which takes in all inputs and passes them to the necessary outputs (standard).
- hosts/ contains all of my separate hosts. 
- modules/ contains modules that are both nixos specific and/or home-manager specific; the goal is for these to be host/platform agnostic, allowing me to swap and exchange them in my hosts at will.

### roadmap
- [ ] resolve hard coded hostnames
- [ ] manage noctalia userspace declaratively (fuzzel, foot, etc)
- [ ] port the mess in hosts/nixos-nitro5/configuration.nix to platform agnostic modules
- [ ] learn how to symlink/wrap neovim and other programs in nix, keeping things declarative

