{ ... }:

{
  imports = [
    ./hardware.nix
    ./hibernation.nix
    ./tweaks.nix
  ];

  networking.hostName = "asus-zenbook";

  system.stateVersion = "25.05";
}
