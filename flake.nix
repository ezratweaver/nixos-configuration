{
  description = "Ezra's NixOS configuration";

  inputs = {
    # Nixpkgs channels
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # AI Tools
    nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs =
    {
      nixpkgs-unstable,
      nixpkgs-2505,
      nix-ai-tools,
      home-manager,
      ...
    }:
    let
      # Configuration
      system = "x86_64-linux";
      nixpkgs = nixpkgs-unstable;
      username = "ezratweaver";

      # Common overlays
      overlays = [
        (final: prev: {
          # Access to stable packages via pkgs.pkgs2505
          pkgs2505 = import nixpkgs-2505 {
            system = prev.system;
            config.allowUnfree = true;
          };

          # AI tools
          aiTools = nix-ai-tools.packages.${prev.system};
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
