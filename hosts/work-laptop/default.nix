{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../configuration.nix
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
