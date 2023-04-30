{ pkgs, config, lib, ... }:

let
in {
  programs.sway = {
    enable = false;
  };
}
