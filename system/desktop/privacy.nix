{ pkgs, ... }:

{

  # Enable mullvad service
  services.mullvad-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    # Mullvad vpn packages
    mullvad
    mullvad-vpn

    openvpn

    # For peer to peer sharing of our favorite cat memes
    transmission_4
    transmission_4-gtk

    # Tor
    tor
    tor-browser
  ];


}
