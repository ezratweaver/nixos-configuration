{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = [
      pkgs.vscode-extensions.asvetliakov.vscode-neovim
    ];
  };
}
