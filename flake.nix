{
  description = "Ezra's NixOS configuration";

  inputs = {
    # Nixpkgs channels
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-2505.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs-2505";
    };

    # AI Tools
    nix-ai-tools.url = "github:numtide/nix-ai-tools";
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs-2505,
      nix-ai-tools,
      home-manager,
      ...
    }:
    let
      # Configuration
      system = "x86_64-linux";
      nixpkgs = nixpkgs-2505;
      username = "ezratweaver";

      # Common overlays
      overlays = [
        (final: prev: {
          # Access to stable packages via pkgs.pkgs2505
          unstable = import nixpkgs-unstable {
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

            (
              { lib, ... }:
              let
                rev = self.rev or "dirty";

                shortRev = builtins.substring 0 7 rev;

                commitMsg =
                  builtins.tryEval
                    (builtins.readFile (
                      builtins.toString (
                        nixpkgs.runCommand "git-subject" { buildInputs = [ nixpkgs.git ]; } ''
                          cd ${toString ./.}
                          git log -1 --pretty=%s > $out
                        ''
                      )
                    )).value or "local build";

                buildTime = lib.formatTime "%Y-%m-%d %H:%M" builtins.currentTime;
              in
              {
                boot.loader.grub.configurationName = "[${shortRev}] ${commitMsg} (${buildTime})";
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
