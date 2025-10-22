export EDITOR=nvim

export PATH="$HOME/.local/bin:$PATH"

# General aliases
alias c='clear'
alias cc='claude'
alias codex='codex -a untrusted -s workspace-write'
alias nf='neofetch'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias sv='sudo -E $EDITOR'

# File listing aliases
unalias l 2>/dev/null
unalias ls 2>/dev/null

alias ls='eza -a --icons'
alias ll='eza -al --icons'

l() {
    local level=1
    local args=()
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -l)
                if [[ $# -ge 2 ]]; then
                    level=$2
                    shift 2
                    continue
                fi
                ;;
            *)
                args+=("$1")
                shift
                ;;
        esac
    done
    
    eza -a --tree --level=$level --icons "${args[@]}"
}

# NixOS aliases
alias nxs="nix-search"
alias nxrollback="sudo nixos-rebuild switch --rollback"
alias nxgenerations="sudo nixos-rebuild list-generations"
alias vnx="nvim ~/nixos-configuration/configuration.nix"
alias nxdir="cd ~/nixos-configuration/"

alias cdf='cd $(find . -type d -print | command fzf)'
alias cdi="zi"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gam="git commit --amend --no-edit"
alias game="git commit --amend"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpl="git pull"
alias gr="git restore"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"
alias grs="git restore --staged"

# Initialize zoxide
eval "$(zoxide init zsh)"

# Zsh options
setopt AUTO_CD              # Change directory without typing cd
setopt HIST_VERIFY         # Show command with history expansion to user before running it
setopt SHARE_HISTORY       # Share command history data
setopt HIST_IGNORE_SPACE   # Don't record commands that start with space
setopt HIST_IGNORE_DUPS    # Don't record duplicates
setopt CORRECT             # Try to correct spelling of commands
setopt COMPLETE_IN_WORD    # Complete from both ends of a word

# Enable completions
autoload -Uz compinit
compinit

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colorize completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# History settings
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

cd() {
    if [[ $# -eq 0 ]]; then
        z "$HOME"
    else
        z "$@"
    fi
}

fzf() {
    local selection
    selection=$(command fzf "$@")
    if [[ -n "$selection" ]]; then
        echo "$selection" | wl-copy
        echo "$selection"
    fi
}

dcp() {
    if [[ -z "$1" ]]; then
        echo "Usage: dcp <file or directory>"
        return 1
    fi
    local dir=$(realpath "$1")
    echo -n "$dir" | wl-copy
    echo "Copied to clipboard: $dir"
}

dcut() {
    if [[ -z "$1" ]]; then
        echo "Usage: dcut <file or directory>"
        return 1
    fi
    local dir=$(realpath "$1")
    echo -n "CUT:$dir" | wl-copy
    echo "Cut to clipboard: $dir"
}

dpaste() {
    local dest=${1:-.}
    local clip=$(wl-paste)
    if [[ "$clip" == CUT:* ]]; then
        local dir="${clip#CUT:}"
        mv "$dir" "$dest"
        echo "Moved: $dir -> $dest"
    else
        cp -r "$clip" "$dest"
        echo "Copied: $clip -> $dest"
    fi
}

make-flake() {
    local flakefile="flake.nix"
    if [[ -e "$flakefile" ]]; then
        echo "$flakefile already exists. Aborting." >&2
        return 1
    fi
    cp ~/nixos-configuration/templates/flake.nix "$flakefile"
    echo "Created $flakefile from ~/nixos-configuration/templates/flake.nix in $(pwd)"
}

nix-develop() {
    nix develop "$@" --command zsh
}

nix-shell() {
    export NIX_SHELL="$@"
    command nix-shell "$@" --run 'env | grep PATH > /tmp/nixpath; zsh'
}

nxreb() {
    source ~/nixos-configuration/.env
    sudo nixos-rebuild switch --flake ~/nixos-configuration/#$NIX_HOST
}

nxupdate() {
    source ~/nixos-configuration/.env
    sudo nix flake update
    sudo nixos-rebuild switch --flake ~/nixos-configuration/#$NIX_HOST
}

vfzf() {
    local cols=$(tput cols)
    local file
    if (( cols > 160 )); then
        file=$(fzf --height=70% --layout=reverse --info=inline --border --margin=1 --padding=1 \
            --preview 'bat --color=always --style=header,grid --line-range :300 {}' \
            --preview-window 'right:50%:wrap')
    else
        file=$(fzf --height=70% --layout=reverse --info=inline --border --margin=1 --padding=1)
    fi
    if [[ -n "$file" ]]; then
        $EDITOR "$file"
    fi
}
