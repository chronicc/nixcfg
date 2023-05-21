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
            ./printers.nix
            ./sway

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.chronicc = {
                imports = [
                  ./modules/bars/eww
                  ./modules/bars/waybar
                  ./dunst.nix
                  ./home.nix
                  ./kitty.nix
                  ./matrix.nix
                  ./obsidian.nix
                  ./office.nix
                  ./swaybg.nix
                  ./swaylock.nix
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
