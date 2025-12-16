{ nixos-hardware, ... }:
{
  imports = [
    ./hardware.nix
    ./tweaks.nix
    ../../configuration.nix
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
  ];

  system.stateVersion = "25.11";
}
