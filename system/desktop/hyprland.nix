{ pkgs, ... }:

{
  # Enable touchpad
  services.libinput.enable = true;

  # Desktop environment
  programs.hyprland.enable = true;
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;

  # Greeter
  services.greetd = {
    enable = true;
    # tuigreet = TUI greeter in the console
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --user-menu";
      user = "greeter";
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # XDG portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
  ];

  # Cursor theme configuration
  environment.sessionVariables = {
    XCURSOR_SIZE = "20";
    HYPRCURSOR_SIZE = "20";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
  };

  environment.systemPackages = with pkgs; [
    # Hyprland desktop apps
    kitty # terminal
    rofi # application launcher
    waybar # status bar
    hyprpaper # wallpaper
    nautilus # file manager
    eww # widgets
    qimgv # image viewer
    pinta # image editor
    kooha # video recording
    hyprshot # screenshots
    hyprpolkitagent # authentication agent
    swaynotificationcenter # notifications
    hyprlock # screen lock
    hypridle # idle management
    hyprpicker # color picker
    nwg-displays # display settings

    # System utilities for Hyprland
    brightnessctl
    pamixer
    pavucontrol
    playerctl
    blueman
    iwgtk
    libadwaita # For libadwaite programs

    # Wayland clipboard utilities
    wl-clipboard
    cliphist

    # Theme stuff
    bibata-cursors
    font-awesome

    gnome-calculator

    adw-bluetooth

    gvfs # for mounting mtp and usb, typicall included in gnome
  ];

  users.users.ezratweaver.extraGroups = [ "plugdev" ];

  # Permissions for usb and mtp
  security.polkit.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
}
