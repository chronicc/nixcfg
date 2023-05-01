{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "Source Code Pro";
      size = 14;
    };
    keybindings = {
      "ctrl+shift+up" = "change_font_size all +2.0";
      "ctrl+shift+down" = "change_font_size all -2.0";
      "ctrl+shift+backspace" = "change_font_size all 0";
    };
    settings = {
      background_opacity = "0.9";
      enable_audio_bell = "no";
      focus_follows_mouse = "no";
      placement_stragegy = "top-left";
      scrollback_lines = "5000";
      touch_scroll_multiplier = "4.0";
      visual_bell_duration = "0.0";
      window_border_width = "0";
      window_margin_width = "4";
      window_padding_width = "0";
    };
    theme = "Gruvbox Dark";
  };
}
