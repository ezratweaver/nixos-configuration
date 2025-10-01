function dcut
    if test -z "$argv[1]"
        echo "Usage: dcut <file or directory>"
        return 1
    end

    set -l dir (realpath $argv[1])
    echo -n "CUT:$dir" | wl-copy
    echo "Cut to clipboard: $dir"
end