{
  description = "chronicc//infrastructure";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url                    = "github:nix-community/home-manager";
    hyprland.inputs.nixpkgs.follows     = "nixpkgs";
    hyprland.url                        = "github:hyprwm/Hyprland";
    nixpkgs.url                         = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgsUnstable.url                 = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsMaster.url                   = "github:nixos/nixpkgs/master";
  };

  outputs = inputs@{ self, home-manager, hyprland, nixpkgs, nixpkgsUnstable, nixpkgsMaster, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgsUnstable = import nixpkgsUnstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgsMaster = import nixpkgsMaster {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      # Pull these packages from different branches
      overridePackages = self: super: {
        skaffold = pkgsUnstable.skaffold;
        vscode = pkgsUnstable.vscode;
      };

      nixosConfigurations = {
        libre = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/libre
            {
              nixpkgs.overlays = [ self.overridePackages ];
              nixpkgs.config.allowUnfree = true;
            }
            #hyprland.nixosModules.default {
            #  programs.hyprland.enable = true;
            #}
          ];
        };
      };
    };
}
