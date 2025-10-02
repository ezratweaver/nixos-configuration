{ pkgs, ... }:
{
  programs.appimage.enable = true;

  services.flatpak.enable = true;

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

  # Shell configuration
  programs.fish.enable = true;
  programs.bash.interactiveShellInit = ''
    if [[ $- == *i* ]] && [[ -z "$FISH_VERSION" ]] && command -v fish >/dev/null 2>&1; then
      exec fish
    fi
  '';

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

    # Formatters
    nodePackages.prettier
    prettierd
    black
    nixfmt-rfc-style

    # Desktop apps
    dbeaver-bin
    azuredatastudio
    discord
    obsidian
    vlc
    onlyoffice-bin
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
    aiTools.codex
    tree
    unzip
    wget
    jq
    bat # Cat with syntax hilighting
    xclip # For nvim copy to clipboard
    railway
    nix-search
    ngrok
    btop
    postgresql
    visidata
  ];

}
