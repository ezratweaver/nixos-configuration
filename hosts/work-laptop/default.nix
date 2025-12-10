{ pkgs, nixos-hardware, ... }:

{
  imports = [
    ./hardware.nix
    ./tweaks.nix
    ../../configuration.nix
    nixos-hardware.nixosModules.dell-latitude-5520
  ];

  # Work specific packages
  environment.systemPackages = with pkgs; [
    teams-for-linux
    awscli2
    s5cmd
    powershell
  ];

  system.stateVersion = "25.05";
}
