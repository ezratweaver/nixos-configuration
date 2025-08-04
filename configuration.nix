{
  imports = [
    ./configuration/networking.nix
    ./configuration/audio.nix
    ./configuration/desktop.nix
    ./configuration/packages.nix
    ./configuration/users.nix
    ./configuration/virtualization.nix
  ];

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "America/New_York";


  system.stateVersion = "25.05"; # DON'T CHANGE THIS AT ANY COST OR THE WORLD ENDS
}

