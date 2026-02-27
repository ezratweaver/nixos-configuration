{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    ryubing
    umu-launcher

    rpcs3

    alvr # Stream to vr

    wine
    winetricks
    protonup-qt
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
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
      };
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  programs.gamemode.enable = true;

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
    extraModprobeConfig = ''
      options bluetooth disable_ertm=Y
    '';
  };
}
