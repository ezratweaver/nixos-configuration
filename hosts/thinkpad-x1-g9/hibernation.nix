{ ... }:

{
  # Input swap disk, using uuid found, via lsblk -f
  boot.resumeDevice = "/dev/disk/by-uuid/d56c1a1f-2226-4b32-a5bc-7ffa91f0808e";

  # Map resume disk
  boot.kernelParams = [
    "resume=/dev/mapper/luks-d62ee072-a9ff-4437-9ec7-dc68b14fbff8"
  ];

  boot.initrd.systemd.enable = true;

  # For Hyprland/GNOME power management
  powerManagement.enable = true;

  # Global suspend then hibernate rule for this device only
  # Since not every device has hibernation set up
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        IdleAction = "suspend-then-hibernate";
        IdleActionSec = "30min";
      };
    };
  };
}
