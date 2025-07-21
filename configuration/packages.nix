{ pkgs, ... }:

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
    hyprpicker # color picker
    pinta # image viewer

    # Clipboard stuff
    xclip
    wl-clipboard

    # Nix stuff
    nix-search

    # Fun stuff
    discord
    obsidian

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
    gemini-cli
    luarocks
    unzip
    wget
    cargo
    prettierd
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

    # Theme stuff
    bibata-cursors
    font-awesome
  ];
}
