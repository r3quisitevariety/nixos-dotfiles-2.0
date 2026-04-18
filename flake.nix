{
  description = "my :3 flake";

  # think of inputs as "fetching" dependencies; other flakes, git repos, local paths.

  inputs = {

    # mixing both stable and unstable
    #nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yt-x = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  # outputs can be thought of as arguments - how are we molding and sculpting the inputs?

  outputs =
    {
      self,
      nixpkgs,
      mangowm,
      nvf,
      ...
    }@inputs:
    {
      # will add future host names here.

      nixosConfigurations.variety = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # fix compiler from bitching about inputs
        modules = [
          mangowm.nixosModules.mango
          ./hosts/nitro5/configuration.nix
          ./home/llms.nix
          ./home/nvf.nix
          ./home/vr.nix
        ];
      };

    };

  # left off at https://nixos-and-flakes.thiscute.world/nixos-with-flakes/nixos-flake-configuration-explained
}
