{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./nvidia.nix
    ./gaming.nix
  ];

  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  networking.hostName = "asus-tuf";

  system.stateVersion = "25.05";
}
