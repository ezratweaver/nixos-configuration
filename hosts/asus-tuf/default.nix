{ ... }:

{
  imports = [
    ./hardware.nix
    ./nvidia.nix
    ./gaming.nix
  ];

  networking.hostName = "asus-tuf";

  system.stateVersion = "25.05";
}
