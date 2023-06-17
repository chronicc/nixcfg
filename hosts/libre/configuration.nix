# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/applications/chromium
      ../../modules/peripherie/bluetooth
      ../../modules/peripherie/keyboard
      ../../modules/peripherie/printers

      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.chronicc.imports = [ ../../users/chronicc ];
      }
    ];

  boot = {
    initrd = {
      luks.devices = {
        crypted = {
          bypassWorkqueues = true;
          device = "/dev/disk/by-partuuid/c952e698-b368-42b0-a43c-aaa890e73ea6";
          preLVM = true;
        };
      };
      systemd.enable = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "boot.shell_on_fail"
      "i915.force_probe=46a6"
      "quiet"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 10;
        enable = true;
      };
      timeout = 1;
    };
    plymouth = {
      enable = true;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de-latin1-nodeadkeys";
  };

  environment = {
    etc = {
    };
    systemPackages = with pkgs; [
      bottom
      dig
      git
      git-lfs
      killall
      nix-index
      pciutils
      usbutils
      vim
      wget
      xdg-utils
    ];
  };

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

  hardware = {
    opengl = {
      driSupport32Bit = true;
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
      ];
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
    };
  };

  networking = {
    extraHosts = ''
      127.0.0.1 my-app-frontend.local my-app-backend.local
    '';
    hostName = "libre";
    networkmanager = {
      enable = true;
      insertNameservers = ["8.8.8.8" "8.8.4.4"];
    };
    wireless.userControlled.enable = true;
  };


  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };

  security = {
    sudo = {
      wheelNeedsPassword = false;
    };
  };

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

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };

  systemd.tmpfiles.rules = [
    "L /bin/bash - - - - ${pkgs.bash}/bin/bash"
    "L /etc/nixos/flake.nix - - - - /home/chronicc/git/chronicc/flakes/flake.nix"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  time.timeZone = "Europe/Berlin";

  users.users.chronicc = {
    extraGroups = [ "audio" "docker" "lp" "networkmanager" "scanner" "video" "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPjRqwfLVi3GXXN97ZlJGdefYv2/HG6iTKOeG+Yqa+1qM82Y/MLyzrNTS1+wlmIB9fPBW3IsIhJtxR9Rw8cj65c= hello@chroni.cc"
    ];
  };

  virtualisation.docker.enable = true;
}
