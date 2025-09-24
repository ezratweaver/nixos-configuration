
{
  description = "Ezra's NixOS configuration";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs-unstable, nixpkgs-2505, home-manager, ... }:
    let
      nixpkgs = nixpkgs-unstable;

      mkNixosSystem = { hostPath }: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          hostPath
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ezratweaver = import ./home/home.nix;
          }

          # Overlay: add access to 2505 packages via pkgs.pkgs2505
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              (final: prev: {
                pkgs2505 = import nixpkgs-2505 {
                  system = prev.system;
                  config.allowUnfree = true;
                };
              })
            ];
          })
        ];
      };
    in {
      nixosConfigurations = {
        black-dell-laptop = mkNixosSystem { hostPath = ./hosts/black-dell-laptop; };
        gaming-laptop     = mkNixosSystem { hostPath = ./hosts/gaming-laptop; };
        work-laptop       = mkNixosSystem { hostPath = ./hosts/work-laptop; };
      };
    };
}

