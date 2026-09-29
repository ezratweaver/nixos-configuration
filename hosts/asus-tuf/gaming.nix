{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ryubing

    rpcs3

    alvr # Stream to vr
  ];

  # Workarounds for XBOX controller (bluetooth)
  hardware.bluetooth.powerOnBoot = true;

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
    extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';
  };
}
