# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./configuration/networking.nix
    ./configuration/audio.nix
    ./configuration/desktop.nix
    ./configuration/packages.nix
    ./configuration/users.nix
  ];

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "America/New_York";


  system.stateVersion = "25.05"; # DON'T CHANGE THIS AT ANY COST OR THE WORLD ENDS
}

