{ pkgs, ... }:

{
  # Shell configuration
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
    };
  };
  users.defaultUserShell = pkgs.zsh;
  users.users.ezratweaver.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    zsh
  ];
}

