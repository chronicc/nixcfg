{ pkgs, config, lib, ... }:

let
in {
  home.packages = with pkgs; [
    fractal
  ];
}
