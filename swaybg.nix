{ pkgs, config, libs, ... }:

let
in {
  home.packages = with pkgs; [
    swaybg
  ];
  xdg.configFile."wallpaper.jpg".source = ./wallpaper.jpg;
}
