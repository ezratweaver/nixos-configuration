{
  networking.hostName = "linux-11807cc6-f4f7-455c-8831-3a7d5cccb104";

  # IWD for netowkring
  networking.wireless.iwd.enable = true;

  # Disable IPv6, because most vpns don't support it out of the box.
  networking.enableIPv6 = false;
 
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
 
  # Enable SSH
  services.openssh.enable = true; 
}
