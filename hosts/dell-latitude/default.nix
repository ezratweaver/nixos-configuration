{ ... }:

{
  imports = [
    ./hardware.nix
    ./git.nix
    ./work-packages.nix
  ];

  networking.hostName = "dell-latitude";

  system.stateVersion = "25.05";
}
