{ nixos-hardware, ... }:
{
  imports = [
    ./hardware.nix
    ./battery.nix
    ./hibernation.nix
    ../../configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
  ];

  system.stateVersion = "25.11";
}
