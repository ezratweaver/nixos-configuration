{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../configuration.nix
    ./git.nix
  ];

  # Work specific packages
  environment.systemPackages = with pkgs; [
    teams-for-linux
    awscli2
    s5cmd
  ];

  system.stateVersion = "25.05";
}
