{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../shared
  ];

  networking.hostName = "work-laptop";
  
  system.stateVersion = "25.05";
}