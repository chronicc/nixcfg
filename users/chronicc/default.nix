{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.chronicc.imports = [
        ./home.nix
        ../../modules/applications/matrix
        ../../modules/applications/obsidian
        ../../modules/applications/office
        ../../modules/applications/vscode
        ../../modules/terminals/terminator
      ];
    }
  ];

  users.users.chronicc.extraGroups = [
    "audio"
    "docker"
    "libvirtd"
    "lp"
    "networkmanager"
    "scanner"
    "video"
    "wheel"
  ];
  users.users.chronicc.initialPassword = "password";
  users.users.chronicc.isNormalUser = true;
  users.users.chronicc.openssh.authorizedKeys.keys = [
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPjRqwfLVi3GXXN97ZlJGdefYv2/HG6iTKOeG+Yqa+1qM82Y/MLyzrNTS1+wlmIB9fPBW3IsIhJtxR9Rw8cj65c= hello@chroni.cc"
  ];
}
