{ pkgs, ... }:

{
  # Enable touchpad
  services.libinput.enable = true;

  # Desktop environment
  programs.hyprland.enable = true;
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;

  environment.systemPackages = with pkgs; [
    # Hyprland desktop apps
    kitty # terminal
    rofi-wayland # application launcher
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
  ];
}
