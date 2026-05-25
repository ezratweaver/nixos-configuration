{ pkgs, ... }:

{
  # Enable mullvad service
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  environment.systemPackages = with pkgs; [
    # Vpn packages
    mullvad
    openvpn
  ];

}
