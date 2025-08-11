{ pkgs, ... }:

{
  # Browser
  programs.firefox.enable = true;

  # Mullvad VPN service
  services.mullvad-vpn.enable = true;

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

    # Fun stuff
    discord
    obsidian
    chromium

    # VPN and network tools
    mullvad
    mullvad-vpn
    openvpn
    transmission_4
    transmission_4-gtk
    
    # API tools
    postman
  ];
}

