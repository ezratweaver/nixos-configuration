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

    ".config/wofi/" = {
      source = ./dotfiles/wofi;
      recursive = true;
    };

    ".config/waybar/" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };

    ".config/swaync/" = {
      source = ./dotfiles/swaync;
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

  # GTK theme configuration for dark mode
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  # Configure GTK settings for dark mode
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
  };

  # dconf settings for GNOME applications
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };
  };
}
