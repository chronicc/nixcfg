{ pkgs, config, lib, ... }:

let
in {
  home = {
    file.".config/sway/config".text = ''
      set $altgr ISO_Level3_Shift
      set $mod Mod4

      bindsym Ctrl+Alt+b exec "chromium --profile-directory=Default"
      bindsym Ctrl+Alt+l exec "swaylock"
      bindsym Ctrl+Alt+t exec "terminator"

      bindsym Alt+$altgr+r reload
      bindsym Alt+$altgr+q exit

      input "type:keyboard" {
        repeat_delay 600
        repeat_rate 25
        xkb_layout de
        xkb_model pc105
        xkb_variant ,nodeadkeys
      }

      output eDP-1 {
        background ~/.config/wallpaper.png fill
        resolution 2880x1400
        scale 1
      }
    '';
    packages = with pkgs; [
      sway
    ];
  };
}
