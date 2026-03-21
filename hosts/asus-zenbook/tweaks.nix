{ ... }:

{
  # enable asusctl
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # better power management
  services.power-profiles-daemon.enable = true;
}
