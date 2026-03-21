{ ... }:

{
  # Input swap disk, using uuid found, via lsblk -f
  boot.resumeDevice = "/dev/disk/by-uuid/09883cd3-af6a-4144-9988-457449e2b496";

  # # Map resume disk
  boot.kernelParams = [
    "resume=/dev/mapper/luks-09883cd3-af6a-4144-9988-457449e2b496"
  ];

  boot.initrd.systemd.enable = true;

  # For Hyprland/GNOME power management
  powerManagement.enable = true;

  # Automatic hibernation settings
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=4h
    HibernateMode=platform shutdown
    SuspendState=mem
  '';

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        IdleAction = "suspend-then-hibernate";
        IdleActionSec = "30min";
        IdleActionInhibitGroup = "none";
      };
    };
  };
}
