function fish_prompt
    # Capture last exit status
    set -l last_status $status

    # Check if we're in a nix shell or nix develop environment
    set -l nix_indicator ""
    if test -n "$IN_NIX_SHELL"
        if test "$IN_NIX_SHELL" = impure
            set nix_indicator (set_color blue)"[nix-shell]"(set_color normal)" "
        else
            set nix_indicator (set_color cyan)"[nix-shell:pure]"(set_color normal)" "
        end
    else if test -n "$NIX_BUILD_TOP"
        set nix_indicator (set_color magenta)"[nix-develop]"(set_color normal)" "
    end

    # Git branch
    set -l git_branch ""
    if type -q git
        set branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if test $status -eq 0
            set git_branch " "(set_color yellow)"($branch)"(set_color normal)
        end
    end

    # Exit status indicator
    set -l status_indicator ""
    if test $last_status -ne 0
        set status_indicator " "(set_color red)"[$last_status]"(set_color normal)
    end

    # Build prompt
    echo -n $nix_indicator
    echo -n (set_color white)(whoami)(set_color normal)" "
    echo -n (set_color $fish_color_cwd)(prompt_pwd)(set_color normal)
    echo -n $git_branch
    echo -n $status_indicator
    echo -n " \$ "
end

