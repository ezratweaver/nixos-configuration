{ nixos-hardware, ... }:
{
  imports = [
    ./hardware.nix
    ./tweaks.nix
    ../../configuration.nix
    nixos-hardware.nixosModules.dell-latitude-5520
  ];

  system.stateVersion = "25.11";
}
