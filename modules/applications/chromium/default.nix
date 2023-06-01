{ config, lib, pkgs, ... }:

let
in {
  environment = {
    systemPackages = with pkgs; [
      chromium
    ];
  };

  nixpkgs.config.chromium = {
    enableWideVine = true;
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "bhchdcejhohfmigjafbampogmaanbfkg" # User Agent Switcher
      "chlffgpmiacpedhhbkiomidkjlcfhogd" # pushbullet
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "mbniclmhobmnbdlbpiphghaielnnpgdp" # lightshot
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    ];
    extraOpts = {
      "HardwareAccelerationModeEnabled" = true;
      "PasswordManagerEnabled" = false;
      "PasswordImport" = false;
    };
  };
}
