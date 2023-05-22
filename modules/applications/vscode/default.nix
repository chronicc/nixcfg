{ config, lib, pkgs, ... }:

let
  # Update vscode extensions with 'make update-vscode-extensions'
  extensions = (import ./extensions.nix).extensions;
in {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    extensions = (builtins.map
      (extension: pkgs.vscode-utils.buildVscodeMarketplaceExtension {
        mktplcRef = {
          inherit (extension) name publisher version sha256;
        };
      }) extensions);
    mutableExtensionsDir = false;
  };
}
