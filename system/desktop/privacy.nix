{ pkgs, ... }:

{

  # Enable mullvad service
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.pkgs2505.mullvad-vpn;
  };

  environment.systemPackages = with pkgs; [
    # Mullvad vpn packages
    mullvad

    openvpn

    # For peer to peer sharing of our favorite cat memes
    transmission_4
    transmission_4-gtk

    # Tor
    tor
    tor-browser
  ];

}
