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
        pkgs.epson-escpr2
        pkgs.gutenprint
      ];
      enable = true;
    };
  };
}
