{ ... }:

{
  # enable asusctl
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  # better power management
  services.power-profiles-daemon.enable = true;

  # hack to fix occasional choppy bluetooth
  boot.extraModprobeConfig = ''
    options iwlwifi bt_coex_active=0
  '';
}
