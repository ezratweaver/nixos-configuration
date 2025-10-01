function nxreb
    source ~/nixos-configuration/.env
    sudo nixos-rebuild switch --flake ~/nixos-configuration/#$NIX_HOST
end