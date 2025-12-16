{ ... }:

{
  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     PLATFORM_PROFILE_ON_AC = "performance";
  #     PLATFORM_PROFILE_ON_BAT = "low-power";
  #
  #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #     CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
  #
  #     START_CHARGE_THRESH_BAT0 = 90;
  #     STOP_CHARGE_THRESH_BAT0 = 98;
  #
  #     WIFI_PWR_ON_AC = "off";
  #     WIFI_PWR_ON_BAT = "on";
  #
  #     # Enable Audio Power Saving
  #     SOUND_POWER_SAVE_ON_AC = 0;
  #     SOUND_POWER_SAVE_ON_BAT = 1;
  #
  #     PCIE_ASPM_ON_AC = "performance";
  #     PCIE_ASPM_ON_BAT = "powersave";
  #
  #     NVME_PIN_STEERING_ON_AC = "performance";
  #     NVME_PIN_STEERING_ON_BAT = "powersave";
  #   };
  # };

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
