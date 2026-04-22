{ pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../configuration.nix
  ];

  # Work specific packages
  environment.systemPackages = with pkgs; [
    teams-for-linux
    awscli2
    s5cmd
    powershell
    sqlcmd
  ];

  programs.git.config.user.email = "eweaver@classicalconversations.com";

  system.stateVersion = "25.05";
}
