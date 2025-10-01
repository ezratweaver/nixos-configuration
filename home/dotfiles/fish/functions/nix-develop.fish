function nix-develop --wraps='nix' --description 'Enter nix develop with fish as shell'
    nix develop $argv --command fish
end