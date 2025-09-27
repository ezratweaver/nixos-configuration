{
  description = "Ezra's NixOS configuration";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs =
    {
      nixpkgs-unstable,
      nixpkgs-2505,
      nix-ai-tools,
      home-manager,
      stylix,
      ...
    }:
    let
      nixpkgs = nixpkgs-unstable;

      mkNixosSystem =
        { hostPath }:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            hostPath
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.ezratweaver = import ./home/home.nix;
            }

            # Overlay: add access to packages via pkgs.pkgs2505
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  (final: prev: {
                    pkgs2505 = import nixpkgs-2505 {
                      system = prev.system;
                      config.allowUnfree = true;
                    };

                    aiTools = nix-ai-tools.packages.${prev.system};
                  })
                ];
              }
            )
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
