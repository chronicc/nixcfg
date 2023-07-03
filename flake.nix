{
  description = "chronicc//infrastructure";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url                    = "github:nix-community/home-manager/release-23.05";
    nixpkgs.url                         = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgsUnstable.url                 = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsMaster.url                   = "github:nixos/nixpkgs/master";
  };

  outputs = inputs@{ self, ... }:
    let
      lib = inputs.nixpkgs.lib;
      system = "x86_64-linux";

      pkgsUnstable = import inputs.nixpkgsUnstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgsMaster = import inputs.nixpkgsMaster {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (self: super: {
            qt6Packages.qt6ct = pkgsUnstable.qt6Packages.qt6ct;
            qt6Packages.qtstyleplugin-kvantum = pkgsUnstable.qt6Packages.qtstyleplugin-kvantum;
            skaffold = pkgsUnstable.skaffold;
            vscode = pkgsUnstable.vscode;
          })
        ];
      };
    in {
      nixosConfigurations = {
        libre = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/libre
          ];
        };

        "vps2.kurthos.com" = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs; };
          modules = [
            ./hosts/vps2.kurthos.com
          ];
        };
      };
    };
}
