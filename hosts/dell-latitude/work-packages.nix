{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    teams-for-linux
    awscli2
    s5cmd
    powershell
    sqlcmd
    azuredatastudio
  ];
}
