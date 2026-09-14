{ ... }:

{
  imports = [
    ./hardware.nix
    ./hibernation.nix
  ];

  networking.hostName = "thinkbook-16";

  system.stateVersion = "25.11";
}
