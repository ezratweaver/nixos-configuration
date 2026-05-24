{ ... }:
{
  imports = [
    ./hardware.nix
    ./battery.nix
    ./hibernation.nix
    ./tweaks.nix
    ../../configuration.nix
  ];

  system.stateVersion = "25.11";
}
