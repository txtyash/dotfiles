{
  description = "Yash's NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      niri-flake,
      ...
    }:
    {
      nixosConfigurations = {
        vivobook = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.yash = ./home.nix;
                extraSpecialArgs = { inherit inputs; };
              };
            }
            niri-flake.nixosModules.niri
          ];
        };
      };
    };
}
