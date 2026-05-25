{ lib, ... }:

{
  imports = [
    ./system/core
    ./system/desktop
    ./system/packages.nix
  ];

  time.timeZone = lib.mkDefault "America/New_York";
}
