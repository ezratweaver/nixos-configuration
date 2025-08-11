{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../shared
  ];

  networking.hostName = "black-dell-laptop";
  
  system.stateVersion = "25.05";
}
