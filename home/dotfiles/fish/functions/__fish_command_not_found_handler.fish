function __fish_command_not_found_handler --on-event fish_command_not_found
    if command -v nix-shell &>/dev/null
        echo "'$argv[1]' not found."
    end
end