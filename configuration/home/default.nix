{ ... }:
{
  imports = [
    ./dotfiles
    ./theme.nix
    ./mime.nix
    ./vscodium.nix
  ];

  home.stateVersion = "24.05";

  xsession.numlock.enable = true;

  programs.home-manager.enable = true;
}
