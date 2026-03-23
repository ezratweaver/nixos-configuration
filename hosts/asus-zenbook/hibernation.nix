{ ... }:

{
  # UUID of the unlocked swap filesystem (not the LUKS container UUID)
  boot.resumeDevice = "/dev/disk/by-uuid/078bdf57-0cb9-464b-86e3-4aec0c7dd9cc";

  # Force AMD to use deep sleep (s2idle is default on AMD, but breaks suspend-then-hibernate)
  boot.kernelParams = [
    "mem_sleep_default=deep"
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
    HibernateMode=shutdown
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
