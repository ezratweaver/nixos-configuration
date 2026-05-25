{
  pkgs,
  lib,
  username,
  ...
}:
{
  programs.appimage.enable = true;

  # Git config
  programs.git = {
    enable = true;
    config = {
      user.name = lib.mkDefault "ezratweaver";
      user.email = lib.mkDefault "${username}@gmail.com";
      push.autoSetupRemote = true;
      pull.rebase = true;
      diff.external = "difft";
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Dev tools
    git
    difftastic
    delta
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
    bun
    go
    tree-sitter
    gh
    gcc
    gnumake
    pnpm
    luarocks
    cargo
    openssl
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
    nil # Nix language server
    gopls # Go language server

    # Desktop apps
    figma-linux
    dbeaver-bin
    discord
    signal-desktop
    obsidian
    vlc
    onlyoffice-desktopeditors
    libreoffice
    postman
    blender
    freecad
    obs-studio
    jetbrains.datagrip
    shotcut
    clapper
    popsicle # usb distro writer
    tomato-c
    sniffnet
    gnome-calendar
    marktext # simple markdown editor
    element-desktop
    qbittorrent

    # Tor
    tor
    tor-browser

    # Terminal utilities
    fzf
    ripgrep
    fd
    zoxide
    eza
    claude-code
    unstable.opencode
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
    motrix
  ];

}
