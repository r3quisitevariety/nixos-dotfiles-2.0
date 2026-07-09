{
  description = "my :3 flake";

  inputs = {
    # uncomment both to mix both stable and unstable
    #nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # pure unstable
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    # will add future host names here.

    homeConfigurations.makoro = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./home.nix
      ];
    };

    nixosConfigurations.variety = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;}; # fix compiler from bitching about inputs
      modules = [
        ./hosts/nitro5/configuration.nix
        #./modules/llms.nix
        #.modules/neovim.nix - declared as a home manager module; how do we resolve this in future? I guess just make most things home manager; also import tree?
        ./modules/vr.nix
        ./modules/obs.nix
        ./modules/substituters.nix
        ./modules/noctalia-greeter.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.makoro = import ./home.nix;
        }
      ];
    };
  };
}
