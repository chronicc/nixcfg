{ pkgs, config, lib, ... }:

let
in {
  boot = {
    kernelParams = [
      "tuxedo_keyboard.brightness=255"
      "tuxedo_keyboard.mode=0"
    ];
  };

  hardware = {
    tuxedo-keyboard.enable = true;
  };
}

# [14:     wl_keyboard] key: serial: 34308; time: 16445928; key: 133; state: 1 (pressed)
#                       sym: Super_L      (65515), utf8: ''
# [14:     wl_keyboard] modifiers: serial: 0; group: 0
#                       depressed: 00000040: Mod4
#                       latched: 00000000
#                       locked: 00000000
# [14:     wl_keyboard] key: serial: 34310; time: 16445930; key: 37; state: 1 (pressed)
#                       sym: Control_L    (65507), utf8: ''
# [14:     wl_keyboard] modifiers: serial: 0; group: 0
#                       depressed: 00000044: Control Mod4
#                       latched: 00000000
#                       locked: 00000000
# [14:     wl_keyboard] key: serial: 34312; time: 16445932; key: 93; state: 1 (pressed)
#                       sym: NoSymbol     (0), utf8: ''
# [14:     wl_keyboard] key: serial: 34313; time: 16445938; key: 93; state: 0 (released)
#                       sym: NoSymbol     (0), utf8: ''
# [14:     wl_keyboard] key: serial: 34314; time: 16445942; key: 37; state: 0 (released)
#                       sym: Control_L    (65507), utf8: ''
# [14:     wl_keyboard] modifiers: serial: 0; group: 0
#                       depressed: 00000040: Mod4
#                       latched: 00000000
#                       locked: 00000000
# [14:     wl_keyboard] key: serial: 34316; time: 16445950; key: 133; state: 0 (released)
#                       sym: Super_L      (65515), utf8: ''
# [14:     wl_keyboard] modifiers: serial: 0; group: 0
#                       depressed: 00000000
#                       latched: 00000000
#                       locked: 00000000
