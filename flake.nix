{
  description = "Ezra's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      mkNixosSystem = { hostPath, modules ? [] }: nixpkgs.lib.nixosSystem {
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
        ] ++ modules;
      };
    in {
      nixosConfigurations = {
        black-dell-laptop = mkNixosSystem { 
          hostPath = ./hosts/black-dell-laptop; 
        };
        gaming-laptop = mkNixosSystem { 
          hostPath = ./hosts/gaming-laptop; 
        };
        work-laptop = mkNixosSystem { 
          hostPath = ./hosts/work-laptop; 
        };
      };
    };
}
