{ pkgs, ... }:

{
  # Formux system dependencies
  environment.systemPackages = with pkgs; [
    # work around for atlas-official
    (stdenv.mkDerivation {
      pname = "atlas-official";
      version = "latest";
      
      src = fetchurl {
        url = "https://release.ariga.io/atlas/atlas-linux-amd64-v0.35.0";
        sha256 = "1rkr51pzb51j2pwx0zf83qai4bk308j984b2r7gqpicqchjrp3lf";
      };
      
      dontUnpack = true;
      
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/atlas
        chmod +x $out/bin/atlas
      '';
    })
    go-swag
    air
  ];
}
