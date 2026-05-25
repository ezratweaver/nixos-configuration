{ pkgs, ... }:

{
  networking.hostName = "91f1c1065ead";

  # IWD for networking
  networking.wireless.iwd.enable = true;

  # Disable IPv6, because most vpns don't support it out of the box.
  networking.enableIPv6 = false;

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
        GATTCache = true;
      };
    };
  };

  services.openssh.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  environment.systemPackages = with pkgs; [
    mullvad
    openvpn
  ];
}
