{ config, pkgs, ... }:
{
  home.stateVersion = "24.05";
  
  home.packages = with pkgs; [
    # Move some packages here if you want
  ];
  
  programs.home-manager.enable = true;
}
