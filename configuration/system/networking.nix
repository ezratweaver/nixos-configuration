{ pkgs, ... }:

{
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
