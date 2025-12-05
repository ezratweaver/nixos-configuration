{
  description = "Ezra's NixOS configuration";

  inputs = {
    # Nixpkgs channels
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2511.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-2511";
    };

    # AI Tools
    nix-ai-tools.url = "github:numtide/nix-ai-tools";
    antigravity-nix.url = "github:jacopone/antigravity-nix";

    adw-bluetooth.url = "github:ezratweaver/adw-bluetooth/develop";
  };

  outputs =
    {
      nixpkgs-unstable,
      nixpkgs-2511,
      nix-ai-tools,
      antigravity-nix,
      home-manager,
      adw-bluetooth,
      ...
    }:
    let
      # Configuration
      system = "x86_64-linux";
      nixpkgs = nixpkgs-2511;
      username = "ezratweaver";

      # Common overlays
      overlays = [
        (final: prev: {
          # Access to unstable packages via pkgs.unstable.*
          unstable = import nixpkgs-unstable {
            system = prev.stdenv.hostPlatform.system;
            config.allowUnfree = true;
          };

          # AI tools
          aiTools = nix-ai-tools.packages.${prev.stdenv.hostPlatform.system};
          antigravity = antigravity-nix.packages.${prev.stdenv.hostPlatform.system};

          # Adwaita bluetooth
          adw-bluetooth = adw-bluetooth.packages.${prev.stdenv.hostPlatform.system}.default;
        })
      ];

      # Home Manager configuration
      homeManagerConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.${username} = import ./home/home.nix;
      };

      # Nixpkgs configuration
      nixpkgsConfig = {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = overlays;
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      # System builder function
      mkNixosSystem =
        { hostPath }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            hostPath
            home-manager.nixosModules.home-manager
            homeManagerConfig
            nixpkgsConfig
          ];
        };
    in
    {
      nixosConfigurations = {
        black-dell-laptop = mkNixosSystem { hostPath = ./hosts/black-dell-laptop; };
        gaming-laptop = mkNixosSystem { hostPath = ./hosts/gaming-laptop; };
        work-laptop = mkNixosSystem { hostPath = ./hosts/work-laptop; };
      };
    };
}
