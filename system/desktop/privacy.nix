{ pkgs, ... }:

{
  # Enable gnome keyring
  # check @/home/dotfiles/hypr/programs.conf for exec statement to run
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

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

    # Tor
    tor
    tor-browser

    element-desktop
    simplex-chat-desktop
  ];

}
