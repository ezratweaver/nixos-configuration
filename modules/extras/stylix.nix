{ pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ../../home/dotfiles/hypr/wallpaper.png;
    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
  ];
}
