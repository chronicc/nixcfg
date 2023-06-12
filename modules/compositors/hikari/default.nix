{ config, lib, pkgs, ... }:

let
  # wallpaper_path = "${xdg.configHome}/${xdg.configFile."wallpaper.jpg".target}";
  font_family = "SauceCodePro Nerd Font Propo Medium";
  wallpaper_path = "/home/chronicc/.config/wallpaper.png";
in {
  home = {
    file = {
      ".config/hikari/hikari.conf" = {
        text = ''
          actions {
            browser = $BROWSER
            terminal = $TERMINAL
          }

          bindings {
            keyboard {
              # L (Logo)
              # S (Shift)
              # C (Control)
              # A (Alt)
              # 5 (AltGr)

              # General
              "A5+q" = quit
              "A5+r" = reload
              "CA+b" = action-browser
              # "CA+l" = lock
              "CA+t" = action-terminal

              # Views
              "LS+q" view-quit
              "L+f" = view-toggle-maximize-full
              "L+left" = view-cycle-next
              "L+right" = view-cycle-prev
              "L+r" = layout-reset
              "L+m" = layout-exchange-view-next
              "L+n" = layout-exchange-view-prev
              "L+l" = mode-enter-layout

              # Workspaces (Sheets)
              "L+0" = workspace-switch-to-sheet-0
              "L+1" = workspace-switch-to-sheet-1
              "L+2" = workspace-switch-to-sheet-2
              "L+3" = workspace-switch-to-sheet-3
              "L+4" = workspace-switch-to-sheet-4
              "L+5" = workspace-switch-to-sheet-5
              "L+6" = workspace-switch-to-sheet-6
              "L+7" = workspace-switch-to-sheet-7
              "L+8" = workspace-switch-to-sheet-8
              "L+9" = workspace-switch-to-sheet-9

              # Virtual Terminals
              "CA+f1" = vt-switch-to-1
              "CA+f2" = vt-switch-to-2
              "CA+f3" = vt-switch-to-3
              "CA+f4" = vt-switch-to-4
              "CA+f5" = vt-switch-to-5
              "CA+f6" = vt-switch-to-6
              "CA+f7" = vt-switch-to-7
              "CA+f8" = vt-switch-to-8
              "CA+f9" = vt-switch-to-9
            }

            mouse {
              "L+left" = mode-enter-move
              "L+right" = mode-enter-resize
            }
          }

          #colorscheme {
          #  background = 0x282C34
          #  foreground = 0x000000
          #  selected   = 0xF5E094
          #  grouped    = 0xFDAF53
          #  first      = 0xB8E673
          #  conflict   = 0xED6B32
          #  insert     = 0xE3C3FA
          #  active     = 0xFFFFFF
          #  inactive   = 0x465457
          #}

          inputs {
            keyboards {
              "*" = {
                repeat-rate = 25
                repeat-delay = 600
                xkb = {
                  layout = "de(nodeadkeys)"
                  model = "pc105"
                }
              }
            }

            pointers {
              "*" = {
                accel = 0.0
                accel-profile = none
                disable-while-typing = false
                middle-emulation = false
                natural-scrolling = false
                scroll-button = middle
              }
              "UNIW0001:00 093A:0255 Touchpad" = {
                accel = 1.0
                accel-profile = adaptive
                disable-while-typing = true
                natural-scrolling = true
              }
            }
          }

          layouts {
            f = full
            s = {
              scale = 0.6
              left = single
              right = stack
            }
          }

          outputs {
            "eDP-1" = {
              background = {
                path = ${wallpaper_path}
                fit = center
              }
            }
          }

          ui {
            border = 1
            gap = 2
            font = ${font_family}
          }
        '';
      };
    };
    packages = with pkgs; [
      hikari
    ];
  };
}
