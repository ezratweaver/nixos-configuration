# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ezratweaver";

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
     enable = true;
     pulse.enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  users.users.ezratweaver = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ];
     initialPassword = "password"; # Please use `passwd` to change this
     packages = with pkgs; [
       tree
     ];
   };


  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Fancy pants stuff not needed for the system to run normally

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  programs.firefox.enable = true;
  programs.hyprland.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  # Packages to install
  environment.systemPackages = with pkgs; [
    # Hyprland essentials
    kitty # terminal
    wofi # application laucnher
    waybar # status bar
    dunst # notification daemon
    hyprpaper # wallpaper
    nautilus # file manager
    brightnessctl # brightness control
    pamixer # audio control
    pavucontrol # audio control gui
    playerctl # media control
    hyprshot # screenshot tool

    # Clipboard stuff
    xclip
    wl-clipboard

    # Dev tools
    fzf
    git
    vim
    neovim
    ripgrep
    fd
    nodejs
    nodePackages.npm
    nodePackages.prettier
    python3
    go
    tree-sitter
    gh
    gcc
    fish
    zoxide
    eza
    claude-code

    # Theme stuff
    bibata-cursors
  ];


  system.stateVersion = "25.05"; # DON'T CHANGE THIS AT ANY COST OR THE WORLD ENDS
}

