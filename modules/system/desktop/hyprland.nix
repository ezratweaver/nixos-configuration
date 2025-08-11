{ pkgs, ... }:

{
  # Enable touchpad
  services.libinput.enable = true;
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  # Desktop environment
  programs.hyprland.enable = true;
}