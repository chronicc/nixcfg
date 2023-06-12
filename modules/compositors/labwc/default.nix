{ config, lib, pkgs, ... }:

let
  config_home = ".config/labwc";
  font_family = "SauceCodePro Nerd Font Propo Medium";
in {
  home = {
    file = {
      "${config_home}/autostart".text = ''
        swaybg -i /home/chronicc/.config/wallpaper.jpg -m fill &
        waybar &>/dev/null &
      '';
      "${config_home}/environment".text = ''
        # This allows xdg-desktop-portal-wlr to function (e.g. for screen-recording)
        XDG_CURRENT_DESKTOP=wlroots

        # Set keyboard layout
        XKB_DEFAULT_LAYOUT=de

        # Set cursor theme.
        # Find icons themes with the command below or similar:
        #     find /usr/share/icons/ -type d -name "cursors"
        # XCURSOR_THEME=breeze_cursors

        # Disable hardware cursors. Most users wouldn't want to do this, but if you
        # are experiencing issues with disappearing cursors, this might fix it.
        # WLR_NO_HARDWARE_CURSORS=1

        # For Java applications such as JetBrains/Intellij Idea, set this variable
        # to avoid menus with incorrect offset and blank windows
        # See https://github.com/swaywm/sway/issues/595
        _JAVA_AWT_WM_NONREPARENTING=1
      '';
      "${config_home}/menu.xml".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <openbox_menu>
          <menu id="some-custom-menu">
            <item label="Reconfigure">
              <action name="Reconfigure" />
            </item>
            <item label="Exit">
              <action name="Exit" />
            </item>
          </menu>
        </openbox_menu>
      '';
      "${config_home}/rc.xml".text = ''
        <?xml version="1.0" ?>
        <labwc_config>

          <!--
            Keybind actions are specified in labwc-actions(5)
            The following keybind modifiers are supported:
              W - window/super/logo
              A - alt
              C - ctrl
              S - shift

            Use <keyboard><default /> to load all the default keybinds (those listed
            below). If the default keybinds are largely what you want, a sensible
            approach could be to start the <keyboard> section with a <default />
            element, and then (re-)define any special binds you need such as launching
            your favourite terminal or application launcher. See rc.xml for an example.

            To generate the raw symbols for keystrokes use
            `python3 -c 'print("S-0x%0x" % ord(">"))'` and replace > with the character.
          -->
          <keyboard>
            <default />

            <repeatRate>25</repeatRate>
            <repeatDelay>600</repeatDelay>

            <keybind key="C-A-b"><action name="Execute" command="chromium -profile-directory=Default" /></keybind>
            <keybind key="C-A-l"><action name="Execute" command="swaylock" /></keybind>
            <keybind key="C-A-t"><action name="Execute" command="terminator" /></keybind>

            <keybind key="A-5-r"><action name="Reconfigure" /></keybind>
            <keybind key="A-5-q"><action name="Exit" /></keybind>
          </keyboard>

        </labwc_config> 
      '';
      "${config_home}/themerc-override".text = ''

      '';
    };
    packages = with pkgs; [
      labwc
    ];
  };
}
