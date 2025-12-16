{ ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      START_CHARGE_THRESH_BAT0 = 90;
      STOP_CHARGE_THRESH_BAT0 = 98;

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # Enable Audio Power Saving
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };
}
