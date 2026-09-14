{ ... }:

{
  imports = [
    ./hardware.nix
    ./hibernation.nix
    ./tweaks.nix
  ];

  networking.hostName = "thinkbook-16";

  system.stateVersion = "25.11";
}
