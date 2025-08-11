{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../shared
  ];

  system.stateVersion = "25.05";
}
