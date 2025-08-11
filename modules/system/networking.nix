{ pkgs, lib, ... }:

let
  # Generate completely anonymous hostname using random hash
  randomHostname = lib.substring 0 8 (builtins.hashString "sha256" (toString builtins.currentTime));
in
{
  networking.hostName = randomHostname;

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
