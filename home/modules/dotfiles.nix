{ ... }:
{
  home.file = {
    ".config/hypr/" = {
      source = ../dotfiles/hypr;
      recursive = true;
    };

    ".config/nvim/" = {
      source = ../dotfiles/nvim;
      recursive = true;
    };

    ".zshrc" = {
      source = ../dotfiles/zsh/zshrc;
    };

    ".p10k.zsh" = {
      source = ../dotfiles/zsh/p10k.zsh;
      recursive = true;
    };

    ".config/kitty/" = {
      source = ../dotfiles/kitty;
      recursive = true;
    };

    ".config/rofi/" = {
      source = ../dotfiles/rofi;
      recursive = true;
    };

    ".config/waybar/" = {
      source = ../dotfiles/waybar;
      recursive = true;
    };

    ".config/swaync/" = {
      source = ../dotfiles/swaync;
      recursive = true;
    };
  };
}
