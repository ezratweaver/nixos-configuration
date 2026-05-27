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
    inputs@{
      ...
    }:
    let
      system = "x86_64-linux";
      defaultNixpkgs = inputs.nixpkgs-2511;
      username = "ezratweaver";
      allowUnfree = true;
      systemPath = ./configuration/system;
      homePath = ./configuration/home;

      # Common overlays
      overlays = [
        # Add NUR Packages
        inputs.nur.overlays.default

        (_: _: {
          # Expose unstable packages
          unstable = import inputs.nixpkgs-unstable {
            system = system;
            config.allowUnfree = allowUnfree;
          };

          stable = import inputs.nixpkgs-2511 {
            system = system;
            config.allowUnfree = allowUnfree;
          };

        })
      ];

      homeManagerConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = {
          username = username;
        };
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

      defaultModules = [
        systemPath
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.adw-bluetooth-git.nixosModules.default
        homeManagerConfig
        nixpkgsConfig
      ];

      # System builder helper
      mkNixosSystem =
        {
          modules,
        }:
        defaultNixpkgs.lib.nixosSystem {
          specialArgs = {
            username = username;
          };
          modules = defaultModules ++ modules;
        };
    in
    {
      nixosConfigurations = {
        asus-tuf = mkNixosSystem { modules = [ ./hosts/asus-tuf ]; };
        dell-latitude = mkNixosSystem { modules = [ ./hosts/dell-latitude ]; };
        thinkpad-x1-g9 = mkNixosSystem {
          modules = [
            ./hosts/thinkpad-x1-g9
            inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
          ];
        };
        asus-zenbook = mkNixosSystem { modules = [ ./hosts/asus-zenbook ]; };
      };
    };
}
