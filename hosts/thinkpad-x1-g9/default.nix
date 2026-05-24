{ ... }:
{
  imports = [
    ./hardware.nix
    ./battery.nix
    ./hibernation.nix
    ./tweaks.nix
  ];

  system.stateVersion = "25.11";
}
