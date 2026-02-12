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

    # NixOS Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";

    adw-bluetooth-git.url = "github:ezratweaver/adw-bluetooth/develop";

    # Nix User Repository
    nur.url = "github:nix-community/NUR";

    # Nix Flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    {
      nixpkgs-unstable,
      nixpkgs-2511,
      home-manager,
      nixos-hardware,
      adw-bluetooth-git,
      nur,
      nix-flatpak,
      ...
    }:
    let
      # Configuration
      system = "x86_64-linux";
      nixpkgs = nixpkgs-2511;
      username = "ezratweaver";

      # Common overlays
      overlays = [
        # NUR overlay
        nur.overlays.default

        (final: prev: {
          # Access to unstable packages via pkgs.unstable.*
          unstable = import nixpkgs-unstable {
            system = prev.stdenv.hostPlatform.system;
            config.allowUnfree = true;
          };

          # Adwaita bluetooth
          adw-bluetooth-git = adw-bluetooth-git.packages.${prev.stdenv.hostPlatform.system}.default;
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
          specialArgs = { inherit nixos-hardware; };
          modules = [
            hostPath
            home-manager.nixosModules.home-manager
            nix-flatpak.nixosModules.nix-flatpak
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
        thinkpad-x1-g9 = mkNixosSystem { hostPath = ./hosts/thinkpad-x1-g9; };
      };
    };
}
