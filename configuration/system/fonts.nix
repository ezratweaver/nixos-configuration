{ pkgs, ... }:

let
  # Not in nixpkgs because of Apple's license, so fetch the prebuilt font
  apple-color-emoji = pkgs.runCommand "apple-color-emoji" {
    src = pkgs.fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-ttf/releases/download/macos-26-20260722-484daf4e/AppleColorEmoji-Linux.ttf";
      hash = "sha256-43x69iZaxKCvbVe8ZehhCad22ZZug0MzRVf2PaSCUW8=";
    };
  } "install -Dm444 $src $out/share/fonts/truetype/AppleColorEmoji.ttf";
in
{
  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-mono
      roboto
      apple-color-emoji
    ];
    fontconfig.defaultFonts.emoji = [ "Apple Color Emoji" ];
  };
}
