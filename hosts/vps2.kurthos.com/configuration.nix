{ config, inputs, lib, pkgs, ... }:

{
  imports = [
    ../../users/root
  ];

  console.font = "Lat2-Terminus16";
  console.keyMap = "de-latin1-nodeadkeys";

  environment.systemPackages = with pkgs; [
    bottom
    curl
    dig
    git
    nmap
    vim
    wget
    whois
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  networking.domain = "kurthos.com";
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.enable = true;
  networking.firewall.logRefusedConnections = false;
  networking.fqdn = "vps2.kurthos.com";
  networking.hostName = "vps2";
  networking.nat.enable = true;
  networking.nat.externalInterface = "ens3";
  networking.useDHCP = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 14d";
  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = "flakes nix-command";

  services.locate.enable = true;

  services.nomad.enable = true;
  services.nomad.enableDocker = true;
  services.nomad.settings = {
    datacenter = "dc1";
    data_dir = "/var/lib/nomad";
    acl = {
      enabled = true;
    };
    client = {
      enabled = true;
    };
    server = {
      enabled = true;
      bootstrap_expect = 1;
    };
  };

  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  services.openssh.ports = [ 2222 ];
  services.openssh.settings.PermitRootLogin = "without-password";
  services.openssh.settings.PasswordAuthentication = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";

  time.timeZone = "Europe/Berlin";

  virtualisation.docker.enable = true;
}
