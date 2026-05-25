{ ... }:
{
  imports = [
    ./hardware.nix
    ./battery.nix
    ./hibernation.nix
    ./tweaks.nix
  ];

  networking.hostName = "thinkpad-x1-g9";

  system.stateVersion = "25.11";
}
