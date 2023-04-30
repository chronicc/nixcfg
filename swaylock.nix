{ pkgs, config, lib, ... }:

let
  theme = {
    color = {
      background = "202020";
      error = "FF6D60";
      foreground = "BBBBBB";
      hidden = "00000000";
      primary = "";
      secondary = "303030";
      success = "59CE8F";
      test = "E22FA3";
      warning = "F7D060";
      info = "39B5E0";
    };
    font = {
      family = "NotoSans Nerd Font";
      sizeXL = "48";
    };
  };
in with theme; {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {

      ## OPTIONS

      # Detach from the controlling terminal after locking.
      daemonize = true;

      # Enable debugging output.
      debug = false;

      # Detach from the controlling terminal after locking.
      ignore-empty-password = true;

      # Show current count of failed authentication attempts.
      show-failed-attempts = false;


      ## APPEARANCE

      # Sets the color of backspace highlight segments.
      bs-hl-color = color.info;

      # Sets the color of backspace highlight segments when Caps Lock is active.
      caps-lock-bs-hl-color = color.secondary;

      # Sets the color of the key press highlight segments when Caps Lock is active.
      caps-lock-key-hl-color = color.secondary;

      # Display the clock in the indicator.
      clock = true;

      timestr = "%X";

      datestr = "%a, %x";

      # Turn the screen into the given color instead of white.
      # If -i is used, this sets the background of the image to the given color.
      # Defaults to white (FFFFFF).
      color = color.background;

      # Disable the text that is shown when Caps Lock is enabled.
      disable-caps-lock-text = false;

      # Sets the font of the text.
      font = font.family;

      # Sets a fixed font size for the indicator text.
      font-size = font.sizeXL;

      # Display the given image, optionally only on the given output.
      # Use -c to set a background color. If the path potentially contains a ':',
      # prefix it with another ':' to prevent interpreting part of it as <output>.
      # image = "";

      # Force hiding the current xkb layout while typing, even if more than one layout is configured or the show-keyboard-layout option is set.
      hide-keyboard-layout = true;

      # Show the current Caps Lock state also on the indicator.
      indicator-caps-lock = true;

      # Sets the indicator to show even if idle.
      indicator-idle-visible = true;

      # Sets the indicator radius. The default value is 50.
      indicator-radius = "400";

      # Sets the indicator thickness. The default value is 10.
      indicator-thickness = "16";

      # Sets the color of the inside of the indicator when Caps Lock is active.
      inside-caps-lock-color = color.hidden;

      # Sets the color of the inside of the indicator when cleared.
      inside-clear-color = color.hidden;

      # Sets the color of the inside of the indicator.
      inside-color = color.hidden;

      # Sets the color of the inside of the indicator when verifying.
      inside-ver-color = color.hidden;

      # Sets the color of the inside of the indicator when invalid.
      inside-wrong-color = color.hidden;

      # Sets the color of the key press highlight segments.
      key-hl-color = color.success;

      # Sets the background color of the box containing the layout text.
      # layout-bg-color = "";

      # Sets the color of the border of the box containing the layout text.
      # layout-border-color = "";

      # Sets the color of the layout text.
      # layout-text-color = "";

      # Sets the color of the line between the inside and ring when Caps Lock is active.
      # line-caps-lock-color = "";

      # Sets the color of the line between the inside and ring when cleared.
      # line-clear-color = "";

      # Sets the color of the line between the inside and ring.
      # line-color = "";

      # Use the inside color for the line between the inside and ring.
      line-uses-inside = false;

      # Use the ring color for the line between the inside and ring.
      line-uses-ring = true;

      # Sets the color of the line between the inside and ring when verifying.
      # line-ver-color = "";

      # Sets the color of the line between the inside and ring when invalid.
      # line-wrong-color = "";

      # Disable the unlock indicator.
      no-unlock-indicator = false;

      # Sets the color of the ring of the indicator when Caps Lock is active.
      ring-caps-lock-color = color.error;

      # Sets the color of the ring of the indicator when cleared.
      ring-clear-color = color.info;

      # Sets the color of the ring of the indicator when typing or idle.
      ring-color = color.secondary;

      # Sets the color of the ring of the indicator when verifying.
      ring-ver-color = color.info;

      # Sets the color of the ring of the indicator when invalid.
      ring-wrong-color = color.error;

      # Image scaling mode: stretch, fill, fit, center, tile, solid_color. Use solid_color to display only the background color, even if a background image is specified.
      # scaling = "fill";

      # Sets the color of the lines that separate highlight segments.
      separator-color = color.hidden;

      # Display the current xkb layout while typing.
      show-keyboard-layout = false;

      # Sets the color of the text when Caps Lock is active.
      text-caps-lock-color = color.error;

      # Sets the color of the text when cleared.
      text-clear-color = color.info;

      # Sets the color of the text.
      text-color = color.foreground;

      # Sets the color of the text when verifying.
      text-ver-color = color.info;

      # Sets the color of the text when invalid.
      text-wrong-color = color.error;
    };
  };
}
