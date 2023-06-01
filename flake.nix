{
  description = "Central Flake Configuration";

  inputs = {
    brave-src.url = "github:nixos/nixpkgs/8ad5e8132c5dcf977e308e7bf5517cc6cc0bf7d8";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.05";
    };

    nixpkgsUnstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, brave-src, home-manager, hyprland, nixpkgs, nixpkgsUnstable, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgsUnstable = import nixpkgsUnstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgsBrave = import brave-src {
        inherit system;
      };

      lib = nixpkgs.lib;
    in {

      # Pull these packages from the stable branch
      stablePackages = self: super: {
        brave = pkgsBrave.brave;
      };

      nixosConfigurations = {
        libre = lib.nixosSystem {
          inherit system;
          modules = [
            { nixpkgs.overlays = [ self.stablePackages ]; }

            ./configuration.nix

            ./modules/applications/chromium

            # ./modules/compositors/sway

            ./modules/login/greetd

            ./modules/peripherie/bluetooth
            ./modules/peripherie/keyboard
            ./modules/peripherie/printers

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.chronicc = {
                imports = [
                  ./home.nix

                  ./modules/applications/matrix
                  ./modules/applications/obsidian
                  ./modules/applications/office
                  ./modules/applications/vscode

                  ./modules/bars/eww
                  ./modules/bars/waybar

                  ./modules/compositors/hyprland

                  ./modules/desktop/dunst
                  ./modules/desktop/swaybg
                  ./modules/desktop/swaylock

                  ./modules/terminals/kitty
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
