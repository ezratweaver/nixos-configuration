function nix-shell --wraps='nix-shell' --description 'Enter nix-shell with fish as shell'
    set -lx NIX_SHELL $argv
    command nix-shell $argv --run 'env | grep PATH > /tmp/nixpath; fish'
end