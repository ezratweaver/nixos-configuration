{ lib, ... }:

{
  imports = [
    ./system/audio.nix
    ./system/boot.nix
    ./system/browsers.nix
    ./system/cleanup.nix
    ./system/flatpak.nix
    ./system/fonts.nix
    ./system/hyprland.nix
    ./system/networking.nix
    ./system/packages.nix
    ./system/printing.nix
    ./system/shell.nix
    ./system/user.nix
    ./system/virtualization.nix
    ./system/vpn.nix
  ];

  time.timeZone = lib.mkDefault "America/New_York";
}
