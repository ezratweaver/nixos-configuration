{ lib, ... }:

{
  imports = [
    ./audio.nix
    ./boot.nix
    ./browsers.nix
    ./cleanup.nix
    ./fonts.nix
    ./hyprland.nix
    ./networking.nix
    ./packages.nix
    ./printing.nix
    ./shell.nix
    ./user.nix
    ./virtualization.nix
  ];

  time.timeZone = lib.mkDefault "America/New_York";
}
