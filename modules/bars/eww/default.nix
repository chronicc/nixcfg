{ config, pkgs, lib, ... }:

let
in {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./config;
  };
}
