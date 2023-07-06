# Nix Configuration

## Architecture

### General Configuration

- Peripherie
  - Printers
  - External Hardware
    - Keyboard
    - Mouse
    - Touchpad
    - Monitors
    - Drawpad
- Baseline Applications

### Device Specific Configuration

- Hardware
  - Keyboard
  - Touchpad
  - Monitor
  - Network Devices (Wifi, Bluetooth, NFC)
- Disk Layout
- Drivers

### User Specific Configuration

- Theme
  - Colors/Transparency
  - Fonts
  - Wallpaper
  - Applications + Application Config
  - Desktop Config
    - Login Manager
    - Compositor
    - Bars
    - Launcher

## Maintaining hosts

## Install a host by deploying a disk image

Run `nixos-generate -f qcow -c hosts/<HOST>/configuration.nix` which creates a disk image of the specified host. This image can then be used to do the initial installation of the server via the host providers web interface. When adding a new server to the config, run `nixos-generate-config` on the server after the server has been installed with the disk image and copy the contents of `/etc/nixos/hardware-configuration.nix` over to this repository.

> Makefile Target: `make host-generate`
>
> Example: `HOST=host.acme.org make host-generate`

## Update a host

A server can be updates by running `nixos-rebuild --no-build-nix --build-host <HOST> --target-host <HOST> --flake .#<HOST> switch` which will push changes to the server, rebuild on the server and eventually switch the configuration on the server if the build is successful.

> Makefile Target: `make host-update`
>
> Example: `HOST=host.acme.org make host-update`
