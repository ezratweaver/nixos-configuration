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

    ".config/fish/" = {
      source = ./dotfiles/fish;
      recursive = true;
    };

    ".config/kitty/" = {
      source = ./dotfiles/kitty;
      recursive = true;
    };
  };
  
  home.packages = with pkgs; [
    # Move some packages here if you want
  ];
  
  programs.home-manager.enable = true;

  # Auto-launch fish if not already in fish and if interactive
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [[ $- == *i* ]] && [[ -z "$FISH_VERSION" ]] && command -v fish >/dev/null 2>&1; then
        exec fish
      fi
    '';
  };

  programs.fish.enable = true;
}
