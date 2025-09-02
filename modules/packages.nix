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

  # Shell configuration 
  programs.fish.enable = true;
  programs.bash.interactiveShellInit = ''
    if [[ $- == *i* ]] && [[ -z "$FISH_VERSION" ]] && command -v fish >/dev/null 2>&1; then
      exec fish
    fi
  '';

  # Mullvad VPN service
  services.mullvad-vpn.enable = true;

  virtualisation.docker.enable = true;

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
      requests
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
    docker

    # Fun stuff
    discord
    obsidian
    (chromium.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        "--enable-wayland-ime"
      ];
    })

    # VPN and network tools
    mullvad
    mullvad-vpn
    openvpn
    transmission_4
    transmission_4-gtk
    
    # API tools
    (postman.overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        wrapProgram $out/bin/postman \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    }))

    # Terminal utilities
    fzf
    ripgrep
    fd
    fish
    zoxide
    eza
    claude-code
    gemini-cli
    tree
    unzip
    wget
    jq
    bat # Cat with syntax hilighting
    xclip # For nvim copy to clipboard
    railway

    # Nix stuff
    nix-search

    vlc
    ngrok
    btop
    postgresql
  ];
}
