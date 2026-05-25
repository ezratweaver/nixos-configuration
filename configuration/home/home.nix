{ ... }:
{
  imports = [
    ./modules
  ];

  home.stateVersion = "24.05";

  xsession.numlock.enable = true;

  programs.home-manager.enable = true;
}
