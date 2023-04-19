{
  description = "Central Flake Configuration";

  inputs = {
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        libre = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.chronicc = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}
