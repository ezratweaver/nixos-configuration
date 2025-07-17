{
  description = "Ezra's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      mkNixosSystem = hardwareConfig: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          hardwareConfig
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.ezratweaver = import ./home.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {
        black-dell-laptop = mkNixosSystem ./hardware/black-dell-laptop.nix;
        gaming-laptop = mkNixosSystem ./hardware/gaming-laptop.nix;
      };
    };
}
