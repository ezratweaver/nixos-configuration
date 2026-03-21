{ ... }:

{
  imports = [
    ./hardware.nix
    ./hibernation.nix
    ./tweaks.nix
    ../../configuration.nix
  ];

  system.stateVersion = "25.05";
}
