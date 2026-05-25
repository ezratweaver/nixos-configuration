{ ... }:
{
  home.file = {
    ".config/hypr/" = {
      source = ./hypr;
      recursive = true;
    };

    ".config/nvim/" = {
      source = ./nvim;
      recursive = true;
    };

    ".zshrc" = {
      source = ./zsh/zshrc;
      recursive = true;
    };

    ".config/kitty/" = {
      source = ./kitty;
      recursive = true;
    };

    ".config/rofi/" = {
      source = ./rofi;
      recursive = true;
    };

    ".config/waybar/" = {
      source = ./waybar;
      recursive = true;
    };

    ".config/swaync/" = {
      source = ./swaync;
      recursive = true;
    };

    ".config/opencode/" = {
      source = ./opencode;
      recursive = true;
    };

    ".claude/" = {
      source = ./claude;
      recursive = true;
    };
  };
}
