# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, lib, pkgs, ... }:

let
  config.flake.location = "/home/chronicc/git/chronicc/flakes/flake.nix";
  config.timezone = "Europe/Berlin";
in {
  imports =
    [
      ../../users/chronicc
      ../../modules/applications/chromium
      ../../modules/peripherie/bluetooth
      ../../modules/peripherie/keyboard
      ../../modules/peripherie/printers
    ];

  boot.initrd.luks.devices.crypted = {
    bypassWorkqueues = true;
    device = "/dev/disk/by-partuuid/c952e698-b368-42b0-a43c-aaa890e73ea6";
    preLVM = true;
  };
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_6_3;
  boot.kernelParams = [
    "boot.shell_on_fail"
    "i915.force_probe=46a6"
    "quiet"
  ];
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 1;
  boot.plymouth.enable = true;

  console.font = "Lat2-Terminus16";
  console.keyMap = "de-latin1-nodeadkeys";

  environment.systemPackages = with pkgs; [
    bottom
    dig
    git
    git-lfs
    killall
    nix-index
    pciutils
    usbutils
    vim
    virt-manager
    wget
    xdg-utils
  ];

  fonts.fonts = with pkgs; [
    carlito
    corefonts
    vegur
    (nerdfonts.override {
      fonts = [
        "Noto"
        "SourceCodePro"
      ];
    })
  ];

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    intel-media-driver
    libvdpau-va-gl
    vaapiIntel
    vaapiVdpau
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  networking.extraHosts = ''
    127.0.0.1 my-app-frontend.local my-app-backend.local
  '';
  networking.firewall.enable = true;
  networking.hostName = "libre";
  networking.nat.enable = true;
  networking.nat.externalInterface = "wlo1";
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = ["8.8.8.8" "8.8.4.4"];
  networking.wireless.userControlled.enable = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.sudo.wheelNeedsPassword = false;

  services.locate.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.xserver.autorun = true;
  services.xserver.enable = true;
  services.xserver.desktopManager.mate.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.layout = "de";
  services.xserver.libinput.enable = true;
  services.xserver.xkbVariant = "nodeadkeys";

  sound.enable = true;
  sound.mediaKeys.enable = true;

  systemd.tmpfiles.rules = [
    "L /bin/bash - - - - ${pkgs.bash}/bin/bash"
    "L /etc/nixos/flake.nix - - - - ${config.flake.location}"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  time.timeZone = "${config.timezone}";

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
}
