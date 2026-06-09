
yes, i have dotfiles i manually copied from ~/.config into normie-dots/, and no i will not change it!

behold, my nixos configuration after ~4 months of using nix including flakes + home manager. 

my design choices are idiomatic with the nixos ecosystem, prioritizing general compatibility with existing documentation. i think you should only go as you need when it comes to nix, that's kind of my philosophy for these dotfiles. 

### overview 
- at the top level, we have flake.nix and home.nix for the big picture management of modules, hosts, etc
- hosts/ directory contains different hosts, currently only a single laptop
- modules contain imports that get passed into either NixOS or home manager, variable based on module type and its purpose

### roadmap
- [ ] truly modularize everything, making flake.nix, home.nix, and configuration.nix a true thin layer onto your actual modules
- [ ] match rebuild switches to automated git commits for 1:1 parity with remote and local
- [ ] resolve hard coded hostnames
- [ ] d-dendritic??

