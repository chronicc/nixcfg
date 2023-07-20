{ config, lib, pkgs, ... }:

let
  font_family = "SauceCodePro Nerd Font Propo Medium";
  font_size   = "14";
in {
  home.packages = with pkgs; [
    terminator
  ];

  home.file = {
    ".config/terminator/config" = {
      source = lib.templateFile "terminator_config" ./config.mustache {
        inherit font_family font_size;
      };
    };
  };
}
