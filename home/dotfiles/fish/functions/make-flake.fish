function make-flake
    set flakefile flake.nix
    if test -e $flakefile
        echo "$flakefile already exists. Aborting." >&2
        return 1
    end

    cp ~/nixos-configuration/templates/flake.nix $flakefile
    echo "Created $flakefile from ~/nixos-configuration/templates/flake.nix in (pwd)"
end