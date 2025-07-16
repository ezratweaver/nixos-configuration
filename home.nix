{ config, pkgs, ... }:
{
  home.stateVersion = "24.05";

  home.file = {
    ".config/hypr/" = {
      source = ./dotfiles/hypr;
      recursive = true;
    };

    ".config/nvim/" = {
      source = ./dotfiles/nvim;
      recursive = true;
    };
  };
  
  home.packages = with pkgs; [
    # Move some packages here if you want
  ];
  
  programs.home-manager.enable = true;
}
