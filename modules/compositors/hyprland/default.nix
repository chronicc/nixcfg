{ config, lib, pkgs, ... }:

let
in {
  home.file.".config/hypr" = {
    source = ./config;
    recursive = true;
  };
}
