{ ... }:

{
  boot.resumeDevice = "/dev/mapper/luks-1c5164ec-f62a-42b4-9a43-f40186b25a90";

  systemd.sleep.settings.Sleep = {
    HibernateDelaySec = "4h";
    HibernateMode = "platform shutdown";
    SuspendState = "mem";
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    IdleAction = "suspend-then-hibernate";
    IdleActionSec = "30min";
    IdleActionInhibitGroup = "none";
  };
}
