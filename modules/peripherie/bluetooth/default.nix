{ config, lib, pkgs, ... }:

let
  cfg = config.hardware.bluetooth;
  hasDisabledPlugins = builtins.length cfg.disabledPlugins > 0;
  package = cfg.package;
in {
  options = {
    hardware.bluetooth = {
      debug = lib.mkEnableOption (lib.mdDoc "enable debug logging");
    };
  };

  config = {
    hardware = {
      bluetooth = {
        enable = true;
        debug = false;
        disabledPlugins = [ "sap" "sapclient" ];
        powerOnBoot = true;
      };
    };

    services = {
      blueman.enable = true;
    };

    systemd.services.bluetooth =
      let
        args = [ "-f" "/etc/bluetooth/main.conf" ]
          ++ lib.optional hasDisabledPlugins
            "--noplugin=${lib.concatStringsSep "," cfg.disabledPlugins}"
          ++ lib.optional cfg.debug "-d";
      in {
        serviceConfig.ExecStart = lib.mkForce [
          ""
          "${package}/libexec/bluetooth/bluetoothd ${lib.escapeShellArgs args}"
        ];
      };
  };
}
