{ ... }:

{
  powerManagement.powertop.enable = true;

  services.undervolt = {
    enable = true;
    p1 = {
      limit = 15;
      window = 28;
    };
    p2 = {
      limit = 25;
      window = 0.002;
    };
  };

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
