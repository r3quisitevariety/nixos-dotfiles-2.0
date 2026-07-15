**update:** I switched to cachyos/arch and im currently in the process of migration; expect major rewrites to the config. this will be a great learning opportunity for me to deepen my nix knowledge.

---

### explanation/justification for operating system choice
Instead of opting for pure nixos, I've chosen to run with arch/cachyos + nix. This has several advantages; namely the ability to do things swiftly which would otherwise be unergonomic and painful in nixos; building cuda accelerated packages, python, javascript, etc. cachy also seems to provide optimizations to my system which is just nice to have; wake from suspend worked without having to do anything, and I've seen a huge fps increase in virtual reality. Ultimately this is an opinionated choice of mine; you are free to use your computer how you want, and some people might be better off with pure nixos or something else. This is just what currently works for me and is what I find convenient, practical, and genuinely useful. 

I also appreciate the ability to first do things messily with arch when I want things done quick, and to later refactor into nix when I want something clean. In essence, you can avoid the pain points of nix if you just need something to work *now*. 


I think nix on arch is brilliant as it also allows you to utilize the vast repository of nixpkgs in substitution of the aur which is often insecure and unsafe, but still have the freedom to use the aur ephemerally when desired/needed.



### explanation/justification for design choices

My design choices are idiomatic with the (current) nix ecosystem, prioritizing general compatibility with existing documentation (sorry, no dendritic here!). this has resulted in me adopting flakes + home manager and keeping a pretty sane file structure. 

I am well aware that there are others who would see this design choice as bloat, however it isn't really important to me as my stylistic choice prioritizes ergonomics and ease of use. I am still *for* learning the nix module system as there are some things that are just truly ineffective with home-manager. despite that though, I think home-manager is a valuable tool, albeit somewhat headstrong and brute.

I pretty much started off with flakes and so they are familiar to me. I might try out alternatives in the future, but I currently have no issues with them; I am aware that they are in a kind of weird spot development-wise though.

### overview 
- at the top level, we have the flake.nix which takes in all inputs and passes them to the necessary outputs (standard).
- hosts/ contains all of my separate hosts. 
- modules/ contains modules that are both nixos specific and/or home-manager specific; the goal is for these to be host/platform agnostic, allowing me to swap and exchange them in my hosts at will.
- normie-dots/ contains anything i'd rather configure natively rather than using nix (this has pros like being able to follow native documentation); i often have home.file or mkOutOfStoreSymlink to symlink these files; neovim is managed in a separate repo.

### roadmap
- [ ] resolve hard coded hostnames
- [ ] manage noctalia userspace declaratively (fuzzel, foot, etc)
- [ ] port the mess in hosts/nixos-nitro5/configuration.nix to platform agnostic modules
- [ ] learn how to symlink/wrap neovim and other programs in nix, keeping things declarative
- [ ] add termux to my nix config

