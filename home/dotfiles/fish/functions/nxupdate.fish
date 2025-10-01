function nxupdate
    source ~/nixos-configuration/.env
    sudo nix flake update
    sudo nixos-rebuild switch --flake ~/nixos-configuration/#$NIX_HOST
end