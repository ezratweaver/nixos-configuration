function dpaste
    set -l dest .
    if test (count $argv) -gt 0
        set dest $argv[1]
    end

    set -l clip (wl-paste)

    if string match -q "CUT:*" $clip
        set -l dir (string replace "CUT:" "" $clip)
        mv $dir $dest
        echo "Moved: $dir -> $dest"
    else
        cp -r $clip $dest
        echo "Copied: $clip -> $dest"
    end
end

