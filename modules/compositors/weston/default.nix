{ config, lib, pkgs, ... }:

let
  # wallpaper_path = "${xdg.configHome}/${xdg.configFile."wallpaper.jpg".target}";
  font_family = "SauceCodePro Nerd Font Propo Medium";
  wallpaper_path = "/home/chronicc/.config/wallpaper.png";
in {
  home = {
    file = {
      ".config/weston.ini" = {
        text = ''
          [core]
          shell=desktop
          xwayland=true
          backend=wayland

          [keyboard]
          keymap_rules=evdev
          keymap_layout=de-nodeadkeys
          keymap_model=pc105
          # keymap_variant=
          # keymap_options=
          repeat-rate=40
          repeat-delay=400
          vt-switching=true

          [libinput]

          [output]
          name=eDP-1
          mode=2880x1400

          [shell]
          background-color=0x00000000
          background-image=${wallpaper_path}
          background-type=scale
          binding-modifier=super
          clock-format=seconds-24h

          [xwayland]
          path=/run/current-system/sw/bin/Xwayland
        '';
      };
    };
    packages = with pkgs; [
      weston
    ];
  };
}
