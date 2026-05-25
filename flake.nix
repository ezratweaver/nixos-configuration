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
      system = "x86_64-linux";
      nixpkgs = nixpkgs-2511;
      username = "ezratweaver";
      allowUnfree = true;
      configurationPath = ./configurations;
      homePath = ./configurations/home/home.nix;

      # Common overlays
      overlays = [
        # Add NUR Packages
        nur.overlays.default

        (_: _: {
          # Expose unstable packages
          unstable = import nixpkgs-unstable {
            system = system;
            config.allowUnfree = allowUnfree;
          };

          # Add adw-bluetooth-git
          adw-bluetooth-git = adw-bluetooth-git.packages.${system}.default;
        })
      ];

      homeManagerConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.${username} = import homePath;
      };

      nixpkgsConfig = {
        nixpkgs.hostPlatform = system;
        nixpkgs.config.allowUnfree = allowUnfree;
        nixpkgs.overlays = overlays;
        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      # System builder function
      mkNixosSystem =
        {
          hostPath,
          hardwareModule ? null,
        }:
        nixpkgs.lib.nixosSystem {
          modules = [
            configurationPath
            hostPath
            home-manager.nixosModules.home-manager
            nix-flatpak.nixosModules.nix-flatpak
            adw-bluetooth-git.nixosModules.default
            homeManagerConfig
            nixpkgsConfig
          ]
          ++ nixpkgs.lib.optional (hardwareModule != null) hardwareModule;
        };
    in
    {
      nixosConfigurations = {
        gaming-laptop = mkNixosSystem { hostPath = ./hosts/gaming-laptop; };
        work-laptop = mkNixosSystem { hostPath = ./hosts/work-laptop; };
        thinkpad-x1-g9 = mkNixosSystem {
          hostPath = ./hosts/thinkpad-x1-g9;
          hardwareModule = nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen;
        };
        asus-zenbook = mkNixosSystem { hostPath = ./hosts/asus-zenbook; };
      };
    };
}
