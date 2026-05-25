{ config, ... }:

{
  # Specific nvidia/hyprland stuff to get nvidia to play nice with wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; # Can try true, but may cause wake issues
    open = false; # Keep proprietary driver
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.variables = {
    # Required for NVIDIA + Wayland compositors like Hyprland
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_DRM_NO_ATOMIC = "1"; # Some NVIDIA cards need this
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
}