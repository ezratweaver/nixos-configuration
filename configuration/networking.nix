{ config, lib, pkgs, ... }:

{
  networking.hostName = "ezratweaver";

  networking.wireless.iwd.enable = true;
  
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  services.openssh.enable = true;
}
