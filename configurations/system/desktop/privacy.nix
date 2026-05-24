{ pkgs, ... }:

{
  # Enable mullvad service
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  environment.systemPackages = with pkgs; [
    # Mullvad vpn packages
    mullvad

    openvpn

    # For peer to peer sharing of our favorite cat memes
    transmission_4
    transmission_4-gtk
    qbittorrent

    # Tor
    tor
    tor-browser

    element-desktop
    simplex-chat-desktop
  ];

}
