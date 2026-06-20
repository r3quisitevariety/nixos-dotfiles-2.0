{
  description = "my :3 flake";

  inputs = {
    # uncomment both to mix both stable and unstable
    #nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # pure unstable
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wivrn = {
      url = "github:WiVRn/WiVRn/v26.6.1";
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

    nixosConfigurations.variety = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;}; # fix compiler from bitching about inputs
      modules = [
        ./hosts/nitro5/configuration.nix
        #./modules/llms.nix
        ./modules/neovim.nix
        ./modules/vr.nix
        ./modules/obs.nix
        ./modules/cuda.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.requisite = import ./home.nix; # replace with your username
        }
      ];
    };
  };
}
