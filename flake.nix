{
  description = "A very basic flake";
  
  # think of inputs as "fetching" dependencies; other flakes, git repos, local paths.

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    stylix = {
      #url = "github:nix-community/stylix/release-25.11";
      url = "github:nix-community/stylix"; # unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # outputs can be thought of as arguments - how are we molding and sculpting the lego block inputs?

  outputs = { self, nixpkgs, stylix, mangowm, ... }@inputs: {
    # will add future host names here.
    nixosConfigurations.variety = nixpkgs.lib.nixosSystem { 
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # fix compiler from bitching about inputs
      modules = [ 
        ./hosts/nitro5/configuration.nix 
        stylix.nixosModules.stylix
      ]; 
    };
  };

# I left off at https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-configuration-explained
}
