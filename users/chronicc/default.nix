{ ... }:
{
  imports = [
    ./home.nix
    ../../modules/applications/matrix
    ../../modules/applications/obsidian
    ../../modules/applications/office
    ../../modules/applications/vscode
    ../../modules/terminals/terminator
  ];
}
