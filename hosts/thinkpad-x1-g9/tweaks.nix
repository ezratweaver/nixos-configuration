{ pkgs, ... }:

{
  services.thermald.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Force the switch from i915 to xe for your Tiger Lake GPU
  boot.kernelParams = [
    "i915.force_probe=!9a49"
    "xe.force_probe=9a49"
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
