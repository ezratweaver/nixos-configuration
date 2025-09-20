{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    heroic
    ryubing
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin];
  };
}
