{ pkgs, ... }:

{
  # NetworkManager for networking, with IWD as the wifi backend
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;
  # Let iwd create its own interface, so wlan0 is not lost on a live switch.
  networking.wireless.iwd.settings.DriverQuirks.DefaultInterface = "";

  # Disable IPv6, because most vpns don't support it out of the box.
  networking.enableIPv6 = false;

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
        GATTCache = true;
        # Specific workarounds for XBOX Controllers
        Privacy = "device";
        JustWorksRepairing = "always";
        Class = "0x000100";
      };
    };
  };

  # Enable XBOX Controller support
  hardware.xpadneo.enable = true;

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
