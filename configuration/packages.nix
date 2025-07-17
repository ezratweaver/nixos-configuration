{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  virtualisation.docker.enable = true;
  
  environment.systemPackages = with pkgs; [
    # Hyprland essentials
    kitty # terminal
    wofi # application laucnher
    waybar # status bar
    hyprpaper # wallpaper
    nautilus # file manager
    brightnessctl # brightness control
    pamixer # audio control
    pavucontrol # audio control gui
    playerctl # media control
    blueman # bluetooth GUI
    iwgtk # wifi GUI
    hyprshot # screenshot tool
    hyprpolkitagent # authentication agent
    swaynotificationcenter # notification center
    hyprlock # lockscreen
    hypridle # idle daemon

    # Clipboard stuff
    xclip
    wl-clipboard

    # Nix stuff
    nix-search

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
    gnumake
    docker
    pnpm 

    # formux specific
    # work around for atlas-official
    (stdenv.mkDerivation {
      pname = "atlas-official";
      version = "latest";
      
      src = fetchurl {
        url = "https://release.ariga.io/atlas/atlas-linux-amd64-latest";
        sha256 = "1xw266mkmyy0s2arf6d9mh82gbpdnmlkhx83ndamdhcf6hyvzgr6";
      };
      
      dontUnpack = true;
      
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/atlas
        chmod +x $out/bin/atlas
      '';
    })
    go-swag
    air

    # Theme stuff
    bibata-cursors
  ];
}
