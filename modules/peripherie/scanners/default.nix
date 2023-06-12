{ pkgs, config, lib, ... }:

let
in {
  hardware.sane = {
    enabled = true;
  };
}
