{ pkgs, ... }:
{
  programs.vscodium = {
    enable = true;
    profiles.default.extensions = [
      pkgs.vscode-extensions.asvetliakov.vscode-neovim
    ];
  };
}
