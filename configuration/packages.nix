{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  virtualisation.docker.enable = true;
  
  environment.systemPackages = with pkgs; [
    # Hyprland essentials
    kitty # terminal
    rofi-wayland # application launcher
    waybar # status bar
    hyprpaper # wallpaper
    kdePackages.dolphin # file manager
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
    hyprpicker # color picker
    nwg-displays # monitor manager
    eww # widgets
    qimgv # image viewer
    pinta # image editor
    kooha # video recording


    # Clipboard stuff
    xclip
    wl-clipboard
    cliphist

    # Nix stuff
    nix-search

    # Fun stuff
    discord
    obsidian
    openvpn
    transmission_4
    transmission_4-gtk

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
    (python313.withPackages (ps: with ps; [
      # Add Python packages here declaratively
      beautifulsoup4
    ]))
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
    gemini-cli
    luarocks
    unzip
    wget
    cargo
    prettierd
    dbeaver-bin
    azuredatastudio
    chromium
    openssl
    jq
    bat
    postman

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

    # Theme stuff
    bibata-cursors
    font-awesome
  ];
}
