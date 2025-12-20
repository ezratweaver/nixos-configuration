{
  # Boot configuration
  boot.loader = {
    # Disable systemd-boot
    systemd-boot.enable = false;

    # Enable GRUB
    grub = {
      enable = true;
      # "nodev" is standard for UEFI systems
      device = "nodev";
      efiSupport = true;
      # This helps avoid some EFI variable issues
      efiInstallAsRemovable = true;
    };

    # Ensure efi variables can be touched if needed
    # Note: If efiInstallAsRemovable is true, some users set this to false
    # to avoid the exact "assertion failed" bug you are seeing.
    efi.canTouchEfiVariables = false;
  };
}
