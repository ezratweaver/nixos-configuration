function dcp
    if test -z "$argv[1]"
        echo "Usage: dcp <file or directory>"
        return 1
    end

    set -l dir (realpath $argv[1])
    echo -n $dir | wl-copy
    echo "Copied to clipboard: $dir"
end

