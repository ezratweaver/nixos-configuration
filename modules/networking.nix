{
  networking.hostName = "91f1c1065ead";

  # IWD for netowkring
  networking.wireless.iwd.enable = true;

  # Randomize mac address
  environment.etc."iwd/main.conf".text = ''
    [General]
    EnableNetworkConfiguration=true

    [Privacy]
    EnableAddressRandomization=true
  '';

  # Disable IPv6, because most vpns don't support it out of the box.
  networking.enableIPv6 = false;
 
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
 
  # Enable SSH
  services.openssh.enable = true; 

  # Enable cloudflared as a local DNS-over-HTTPS proxy (avoid dns query spying)
  services.cloudflared = {
    enable = true;
    config = ''
      proxy-dns: true
      proxy-dns-port: 5053
      proxy-dns-upstream:
        - https://mozilla.cloudflare-dns.com/dns-query
    '';
  };

  # Set system DNS to point to local cloudflared proxy
  networking.nameservers = [ "127.0.0.1" ];
}
