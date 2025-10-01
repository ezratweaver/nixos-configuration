function vfzf
    set cols (tput cols)
    if test $cols -gt 160
        # Wide enough for preview (80+ cols for fzf + 80+ for preview)
        set file (fzf --height=70% --layout=reverse --info=inline --border --margin=1 --padding=1 \
        --preview 'bat --color=always --style=header,grid --line-range :300 {}' \
        --preview-window 'right:50%:wrap')
    else
        # Too narrow, no preview
        set file (fzf --height=70% --layout=reverse --info=inline --border --margin=1 --padding=1)
    end

    if test -n "$file"
        $EDITOR $file
    end
end