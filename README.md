# Flakes Configuration

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

## Deploy a server

### By deploying a disk image

Run `nixos-generate -f qcow -c hosts/<HOST>/configuration.nix` which creates a disk image of the specified host. This image can then be used to do the initial installation of the server via the host providers web interface. When adding a new server to the config, run `nixos-generate-config` on the server after the server has been installed with the disk image and copy the contents of `/etc/nixos/hardware-configuration.nix` over to this repository.
