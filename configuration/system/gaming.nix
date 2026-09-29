{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mangohud # Performance overlay
    protontricks
    protonup-qt

    # Run windows games outside of steam
    heroic
    lutris
    umu-launcher
    wine
    winetricks
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamescope.enable = true;

  # 32 bit support is required by Proton
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];
  };

  programs.gamemode.enable = true;
}
