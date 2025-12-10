{ ... }:
{
  # Force S3 sleep mode to preserve battery during sleep (idk what that means)
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Fix for sdcard reader
  boot.blacklistedKernelModules = [ "firewire_ohci" ];

  # Fix Intel cpu throttling
  services.throttled.enable = true;
}
