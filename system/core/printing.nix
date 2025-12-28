{ ... }:

{

  services.printing.enable = true;

  # Cups available at localhost:631
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

}
