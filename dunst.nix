{ config, lib, pkgs, ... }:

let
in {
  home.packages = with pkgs; [ libnotify ];
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
      size = "16x16";
    };

    settings = {
      global = {
        alignment = "left";
        class = "Dunst";
        corner_radius = 7;
        follow = "mouse";
        font = "Source Code Pro 16";
        frame_color = "#89B4FA";
        frame_width = 1;
        hide_duplicate_count = true;
        horizontal_padding = 8;
        icon_position = "left";
        idle_threshold = 120;
        indicate_hidden = true;
        line_height = 0;
        markup = "full";
        max_icon_size = 32;
        min_icon_size = 0;
        notification_height = 0;
        offset = "20x20";
        origin = "bottom-right";
        padding = 8;
        separator_color = "frame";
        separator_height = 2;
        show_age_threshold = 60;
        show_indicators = true;
        sort = true;
        stack_duplicates = true;
        startup_notification = true;
        text_icon_padding = 0;
        timeout = 8;
        title = "Dunst";
        vertical_alignment = "center";
        word_wrap = true;
      };

      urgency_critical = {
        background = "#1E1E2ECC";
        foreground = "#CDD6F4";
        frame_color = "#FAB387";
      };

      urgency_low = {
        background = "#1E1E2ECC";
        foreground = "#CDD6F4";
      };

      urgency_normal = {
        background = "#1E1E2ECC";
        foreground = "#CDD6F4";
      };
    };
  };
}
