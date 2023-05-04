{ pkgs, config, lib, ... }:

let
  # fallback revision in case of breakage
  oldpkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/79b3d4bcae8c7007c9fd51c279a8a67acfa73a2a.tar.gz";
    sha256 = "1lsrlgx4rg2wqxrz5j7kzsckgk4ymvr1l77rbqm1zxap6hg07dxf";
  }) { inherit (pkgs) system; };
in {
  home.packages = with pkgs; [
    oldpkgs.element-desktop
    # fractal
  ];
}
