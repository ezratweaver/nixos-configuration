{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Git config
  programs.git = {
    enable = true;
    config = {
      user.name = "ezratweaver";
      user.email = "ezratweaver@gmail.com";
    };
  };

  # Browser
  programs.firefox.enable = true;

  # Mullvad VPN service
  services.mullvad-vpn.enable = true;

  environment.systemPackages = with pkgs; [
    # Dev tools
    git
    vim
    neovim
    nodejs
    nodePackages.npm
    nodePackages.prettier
    (python313.withPackages (ps: with ps; [
      beautifulsoup4
    ]))
    go
    tree-sitter
    gh
    gcc
    gnumake
    pnpm 
    luarocks
    cargo
    prettierd
    openssl
    dbeaver-bin
    azuredatastudio

    # formux specific
    # work around for atlas-official
    (stdenv.mkDerivation {
      pname = "atlas-official";
      version = "latest";
      
      src = fetchurl {
        url = "https://release.ariga.io/atlas/atlas-linux-amd64-v0.35.0";
        sha256 = "1rkr51pzb51j2pwx0zf83qai4bk308j984b2r7gqpicqchjrp3lf";
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

    # Hyprland desktop apps
    kitty # terminal
    rofi-wayland # application launcher
    waybar # status bar
    hyprpaper # wallpaper
    nautilus # file manager
    eww # widgets
    qimgv # image viewer
    pinta # image editor
    kooha # video recording
    hyprshot # screenshots
    hyprpolkitagent # authentication agent
    swaynotificationcenter # notifications
    hyprlock # screen lock
    hypridle # idle management
    hyprpicker # color picker
    nwg-displays # display settings

    # Fun stuff
    discord
    obsidian
    chromium

    # VPN and network tools
    mullvad
    mullvad-vpn
    openvpn
    transmission_4
    transmission_4-gtk
    
    # API tools
    postman

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

    # Theme stuff
    bibata-cursors
    font-awesome
  ];
}
