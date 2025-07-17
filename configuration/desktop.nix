{ pkgs, ... }:

{

  # Create a service to enable numlock on boot
  systemd.services.numlock = {
    description = "Enable NumLock on boot";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.kbd}/bin/setleds -D +num";
    };
  };
  
  # Enable touchpad
  services.libinput.enable = true;
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  # Browser
  programs.firefox.enable = true;

  # Desktop environment
  programs.hyprland.enable = true;
  
  # Git config
  programs.git = {
    enable = true;
    config = {
      user.name = "ezratweaver";
      user.email = "ezratweaver@gmail.com";
    };
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
}
