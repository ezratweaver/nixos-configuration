{
  imports = [
    ./system/core
    ./system/desktop
    ./system/packages.nix
  ];

  services.automatic-timezoned.enable = true;
}
