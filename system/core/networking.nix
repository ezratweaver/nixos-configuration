{
  networking.hostName = "91f1c1065ead";

  # IWD for netowkring
  networking.wireless.iwd.enable = true;

  # Disable IPv6, because most vpns don't support it out of the box.
  networking.enableIPv6 = false;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Enable SSH
  services.openssh.enable = true;
}
