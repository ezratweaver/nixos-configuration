{ pkgs, ... }:

{
  # Boot configuration
  boot.loader = {
    # Disable systemd-boot
    systemd-boot.enable = false;

    # Enable GRUB
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;

      theme = pkgs.minimal-grub-theme;
    };

    efi.canTouchEfiVariables = false;
  };

  boot.plymouth = {
    enable = true;

    theme = "hexagon_dots";
    themePackages = with pkgs; [
      # By default we would install all themes
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "hexagon_dots" ];
      })
    ];
  };

  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
}
