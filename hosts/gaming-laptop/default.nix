{
  imports = [
    ./hardware.nix
    ./nvidia.nix
    ../../configuration.nix
  ];

  system.stateVersion = "25.05";
}
