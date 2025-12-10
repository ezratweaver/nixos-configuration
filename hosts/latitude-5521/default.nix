{ nixos-hardware, ... }:
{
  imports = [
    ./hardware.nix
    ../../configuration.nix
    nixos-hardware.nixosModules.dell-latitude-5520
  ];

  system.stateVersion = "25.11";
}
