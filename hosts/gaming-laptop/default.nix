{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../shared
  ];

  networking.hostName = "gaming-laptop";
  
  system.stateVersion = "25.05";
}