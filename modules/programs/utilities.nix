{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal utilities
    fzf
    ripgrep
    fd
    fish
    zoxide
    eza
    claude-code
    tree
    unzip
    wget
    jq
    bat

    # Clipboard stuff
    xclip
    wl-clipboard
    cliphist

    # Nix stuff
    nix-search

    # System utilities
    brightnessctl
    pamixer
    pavucontrol
    playerctl
    blueman
    iwgtk
    hyprshot
    hyprpolkitagent
    swaynotificationcenter
    hyprlock
    hypridle
    hyprpicker
    nwg-displays

    # Theme stuff
    bibata-cursors
    font-awesome
  ];
}

