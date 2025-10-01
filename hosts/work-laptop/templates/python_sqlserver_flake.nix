{
  description = "Dev shell with Python + SQL Server ODBC driver + pandas/sqlalchemy/pyodbc";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python3
          pkgs.unixODBC
          pkgs.unixODBCDrivers.msodbcsql18

          (pkgs.python3.withPackages (
            ps: with ps; [
              pandas
              sqlalchemy
              pyodbc
            ]
          ))
        ];

        shellHook = ''
          echo "✅ Dev shell ready: Python + unixODBC + msodbcsql18 + pandas/sqlalchemy/pyodbc"
        '';
      };
    };
}
