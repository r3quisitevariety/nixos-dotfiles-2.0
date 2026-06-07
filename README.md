
yes, i have dotfiles i manually copied from ~/.config into normie-dots/, and no i will not change it!

behold, my nixos configuration after ~4 months of using nix. flakes, home manager, bunch of legacy stuff i havent refactored. i would rewrite everything for clarity except it doesnt really matter for now. i think you should only go as you need when it comes to nix, that's kind of my philosophy for these dotfiles.

feel free to pick and choose, get inspired from, or take from this code. i aimed to make these as lazy as possible and idiomatic with most stuff in the nixos ecosystem, so i haven't opted for anything crazy like dendritic, lots of my design style and choices are standard throughout many other people's dotfiles. Granted, this isn't as granular as some setups (i.e nixpkgs channel isnt pinned, therefore is my system really reproducible??? upstream breaking change might mess up reproducibility in the future.), but its 80% of the way there of reaping the benefits from nix without going too crazy. ofc this is all bound to change in the future.

### overview 
- at the top level, we have flake.nix and home.nix for the big picture management of modules, hosts, etc
- hosts/ directory contains different hosts, currently only a single laptop
- modules contain imports that get passed into either NixOS or home manager, variable based on module type and its purpose

### roadmap
- [ ] truly modularize everything, making flake.nix, home.nix, and configuration.nix a true thin layer onto your actual modules
- [ ] pin nixpkgs for true reproducibility, or flake import everything??? lol 
- [ ] match rebuild switches to automated git commits for 1:1 parity with remote and local
- [ ] resolve hard coded hostnames
- [ ] d-dendritic??
- [ ] clean up legacy code

