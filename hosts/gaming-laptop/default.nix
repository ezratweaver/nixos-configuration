{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./nvidia.nix
    ./gaming.nix
    ../../configuration.nix
  ];

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  system.stateVersion = "25.05";
}
