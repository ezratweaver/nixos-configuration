{
  description = "Example flake file, use nix-develop to shell into this environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        # pkgs.git
        # pkgs.nodejs
        # pkgs.python3
      ];
    };
  };
}

