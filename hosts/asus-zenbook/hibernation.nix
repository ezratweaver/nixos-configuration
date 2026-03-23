{ ... }:

{
  # Input swap disk, using uuid found, via lsblk -f
  boot.resumeDevice = "/dev/disk/by-uuid/078bdf57-0cb9-464b-86e3-4aec0c7dd9cc";

  # Map resume disk
  boot.kernelParams = [
    "resume=/dev/mapper/luks-09883cd3-af6a-4144-9988-457449e2b496"
  ];

  boot.initrd.systemd.enable = true;

  # For Hyprland/GNOME power management
  powerManagement.enable = true;

  # Lock screen before suspend/hibernate (triggered by lid close or idle)
  systemd.services."hyprlock-on-sleep" = {
    description = "Lock screen with hyprlock before sleep";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/bash -c 'loginctl lock-sessions'";
      TimeoutSec = 5;
    };
  };

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
