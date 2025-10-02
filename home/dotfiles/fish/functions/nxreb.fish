function nxreb
    source ~/nixos-configuration/.env

    set shortRev (git -C ~/nixos-configuration rev-parse --short HEAD 2>/dev/null; or echo dirty)
    set commitMsg (git -C ~/nixos-configuration log -1 --pretty=%s 2>/dev/null; or echo "local build")
    set buildTime (date "+%Y-%m-%d %H:%M")

    set profileName "[$shortRev] $commitMsg ($buildTime)"

    sudo nixos-rebuild switch --flake ~/nixos-configuration/#$NIX_HOST --profile-name "$profileName"
end

