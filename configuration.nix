# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
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
    kernelParams = [ "boot.shell_on_fail" "i915.force_probe=46a6" "quiet" ];
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
      "greetd/greeter.jpg".source = ./greeter.jpg;
    };
    systemPackages = with pkgs; [
      bottom
      git
      killall
      pciutils
      usbutils
      vim
      wget
    ];
    variables = {
      NIXOS_OZONE_WL = "1";
      VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
      # XKB_DEFAULT_RULES = "";
      XKB_DEFAULT_MODEL = "pc105";
      XKB_DEFAULT_LAYOUT = "de";
      XKB_DEFAULT_VARIANT = "nodeadkeys";
      # XKB_DEFAULT_OPTIONS = "";
    };
  };

  fonts.fonts = with pkgs; [
    carlito
    corefonts
    nerdfonts
    source-code-pro
    vegur
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
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
    hostName = "libre";
    networkmanager.enable = true;
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

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };
  };

  programs = {
    regreet = {
      enable = true;
      settings = ./dotfiles/regreet/regreet.toml;
    };
    ssh.startAgent = true;
  };
  
  security = {
    rtkit = {
      enable = true;
    };
    polkit = {
      enable = true;
    };
    sudo = {
      wheelNeedsPassword = false;
    };
  };

  services = {
    actkbd = {
      enable = true;
      bindings = [
        { keys = [ 121 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l chronicc -c 'amixer -q set Master toggle'"; }
        { keys = [ 122 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l chronicc -c 'amixer -q set Master 5%- unmute'"; }
        { keys = [ 123 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l chronicc -c 'amixer -q set Master 5%+ unmute'"; }
      ];
    };
    blueman.enable = true;
    greetd = {
      enable = true;
      restart = true;
    };
    illum.enable = true;
    locate = {
      enable = true;
    };
    openssh = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
      # volumeStep = "5%";
    };
  };

  time.timeZone = "Europe/Berlin";

  users.users.chronicc = {
    extraGroups = [ "audio" "lp" "networkmanager" "video" "wheel" ];
    initialPassword = "password";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPjRqwfLVi3GXXN97ZlJGdefYv2/HG6iTKOeG+Yqa+1qM82Y/MLyzrNTS1+wlmIB9fPBW3IsIhJtxR9Rw8cj65c= hello@chroni.cc"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

