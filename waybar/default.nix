{ config, pkgs, lib, ... }:

let
in {
  home.packages = with pkgs; [
    playerctl
    pulsemixer
    xdg-utils
  ];

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";

        modules-left = [
          "wlr/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "battery"
          "pulseaudio"
        ];

        "wlr/workspaces" = {
          on-click = "activate";
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
          sort-by-number = true;
        };

        bluetooth = {
          format = ""; # nf-mdi-bluetooth (f293)
          format-off = ""; # nf-mdi-bluetooth_off (f294)
          on-click = "blueman-manager";
          tooltip = true;
          tooltip-format = "{device_enumerate}";
        };

        clock = {
          format = "{:%a %d.%m.%Y  %H:%M:%S}";
          interval = 1;
          tooltip = false;
        };

        "custom/spacer" = {
          format = " ";
        };

        disk = {
          interval = 30;
          format = " {free} free"; # nf-fa-floppy-o (f0c7)
          path = "/";
        };

        network = {
          format-ethernet = "󰈀"; # nf-md-ethernet (f796)
          format-disconnected = "󰤭"; # nf-md-wifi-strength-off (f57b)
          format-icons = [
            "󰤟" # nf-md-wifi-strength-1 (f57d)
            "󰤢" # nf-md-wifi-strength-2 (f580)
            "󰤥" # nf-md-wifi-strength-3 (f583)
            "󰤨" # nf-md-wifi-strength-4 (f586)
          ];
          format-wifi = "{icon}";
          interval = 5;
          on-click = "nm-connection-editor";
          tooltip-format = "{ifname}: {ipaddr}/{cidr} -> {gwaddr}";
          tooltip-format-wifi = "Name: {essid}\nFrequency: {frequency}Ghz\nSignal: {signalStrength}%\n\nInterface: {ifname}\nAddress: {ipaddr}/{cidr}\nGateway: {gwaddr}\n\n {bandwidthUpBytes}\n {bandwidthDownBytes}";
        };

        pulseaudio = {
          format = "{icon} {volume:2}%";
          format-muted = "󰝟 {volume:2}%"; # nf-md-volume-off (f57d)
          format-icons = {
            default = [
              "󰕿" # nf-md-volume-low (f57f)
              "󰖀" # nf-md-volume-medium (f580)
              "󰕾" # nf-md-volume-high (f57e)
              "" # nf-fa-volume-up (f028)
            ];
          };
          scroll-step = 5;
          on-click = "pamixer -t";
          on-click-right = "pavucontrol";
        };

        memory = {
          interval = 5;
          format = " {used:0.1f}/{total:0.1f}GiB"; # nf-fa-microchip (f2db)
          states = {
            good = 90;
            warning = 25;
            critical = 10;
          };
        };

        cpu = {
          interval = 5;
          format = "󰚩 {usage:2}%"; # nf-md-robot (f2d4)
          format-icons = [

          ];
        };

        battery = {
          states = {
            good = 90;
            critical = 10;
          };
          format = "{icon}";
          format-icons = [
            "" # nf-mdi-battery_10 (f579)
            "" # nf-mdi-battery_20 (f57a)
            "" # nf-mdi-battery_30 (f57b)
            "" # nf-mdi-battery_40 (f57c)
            "" # nf-mdi-battery_50 (f57d)
            "" # nf-mdi-battery_60 (f57e)
            "" # nf-mdi-battery_70 (f57f)
            "" # nf-mdi-battery_80 (f580)
            "" # nf-mdi-battery_90 (f581)
            "" # nf-mdi-battery (f578)
          ];
          tooltip = true;
          tooltip-format = "Capacity: {capacity}%\n{timeTo}";
        };

        tray = {
          icon-size = 18;
          show-passive-items = true;
          spacing = 4;
        };
      }
    ];
    style = ./styles/simple.css;
  };

  xdg.configFile."waybar/scripts" = {
    source = ./scripts;
    recursive = true;
  };
}
