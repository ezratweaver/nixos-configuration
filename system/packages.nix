{ pkgs, ... }:
{
  programs.appimage.enable = true;

  # Git config
  programs.git = {
    enable = true;
    config = {
      user.name = "ezratweaver";
      user.email = "ezratweaver@gmail.com";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # Dev tools
    git
    vim
    unstable.neovim
    nodejs
    nodePackages.npm
    (python313.withPackages (
      ps: with ps; [
        beautifulsoup4
        requests
      ]
    ))
    go
    tree-sitter
    gh
    gcc
    gnumake
    pnpm
    luarocks
    cargo
    openssl
    docker
    clang
    ffmpeg
    ffmpeg-full

    # Formatters
    prettierd
    black
    nixfmt-rfc-style
    stylua

    # Lsps
    lua-language-server # The executable mason provides is not compatible with nixos
    blueprint-compiler # Include the blueprint LSP for gtk .blp files
    clang-tools

    # Desktop apps
    dbeaver-bin
    azuredatastudio
    discord
    signal-desktop
    obsidian
    vlc
    onlyoffice-desktopeditors
    (postman.overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        wrapProgram $out/bin/postman \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    }))
    blender
    obs-studio
    jetbrains.datagrip
    antigravity.google-antigravity
    shotcut
    clapper
    popsicle # usb distro writer

    # Terminal utilities
    fzf
    ripgrep
    fd
    zoxide
    eza
    claude-code
    gemini-cli
    code-cursor
    tree
    unzip
    wget
    jq
    bat # Cat with syntax hilighting
    xclip # For nvim copy to clipboard
    railway
    nix-search
    ngrok
    postgresql
    visidata
    p7zip
    unrar
    file-roller
    fastfetch

    # system monitoring utils
    inxi
    powertop
    btop
  ];

}
