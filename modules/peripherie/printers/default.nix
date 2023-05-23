{ pkgs, config, lib, ... }:

let
in {
  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };
    printing = {
      drivers = [
        pkgs.gutenprint
      ];
      enable = true;
    };
  };
}
