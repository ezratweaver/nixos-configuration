{ ... }:

{
  imports = [
    ./hardware.nix
    ./hibernation.nix
    ./tweaks.nix
  ];

  system.stateVersion = "25.05";
}
