{
  description = "Central Flake Configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, home-manager, hyprland, nixpkgs, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        libre = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            ./greetd
            ./sway

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.chronicc = {
                imports = [
                  ./dunst.nix
                  ./home.nix
                  ./kitty.nix
                  ./matrix.nix
                  ./obsidian.nix
                  ./swaybg.nix
                  ./swaylock.nix
                  ./waybar
                ];
              };
            }

            hyprland.nixosModules.default {
              programs.hyprland.enable = true;
            }
          ];
        };
      };
    };
}
