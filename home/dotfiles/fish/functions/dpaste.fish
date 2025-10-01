function dpaste
    set -l clip (wl-paste)

    if string match -q "CUT:*" $clip
        set -l dir (string replace "CUT:" "" $clip)
        mv $dir .
        echo "Moved: $dir -> (pwd)"
    else
        cp -r $clip .
        echo "Copied: $clip -> (pwd)"
    end
end