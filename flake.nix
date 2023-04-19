{
  description = "Central Flake Configuration";

  inputs = {
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { home-manager, hyprland, nixpkgs, self }:
    let
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      system = "x86_64-linux";
    in {
      homeConfigurations = {
        "chronicc@libre" = home-manager.lib.homeManagerConfiguration {
          modules = [
            hyprland.homeManagerModules.default {
              wayland.windowManager.hyprland.enable = true;
            }
          ];
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        };
      };
      nixosConfigurations = {
        "libre" = lib.nixosSystem {
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
            hyprland.nixosModules.default {
              programs.hyprland.enable = true;
            }
          ];
        };
      };
    };
}
