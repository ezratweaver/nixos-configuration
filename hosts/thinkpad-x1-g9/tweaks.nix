{ pkgs, ... }:

{
  services.thermald.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
    ];
  };

  services.undervolt = {
    enable = true;
    p1 = {
      limit = 15;
      window = 28;
    };
    p2 = {
      limit = 25;
      window = 0.002;
    };
  };
}
