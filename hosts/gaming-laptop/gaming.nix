{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    ryubing

    rpcs3

    alvr # Stream to vr
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin];
  };

  # Workarounds for XBOX controller (bluetooth)
  hardware.xpadneo.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
        FastConnectable = "true";
      };
    };
  };


  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
    extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';
  };
}
