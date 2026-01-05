{ lib, ... }:

{
  imports = [
    ./system/core
    ./system/desktop
    ./system/packages.nix
  ];

  services.geoclue2.enable = true;

  time.timeZone = lib.mkDefault "America/New_York";

  services.automatic-timezoned.enable = true;
}
