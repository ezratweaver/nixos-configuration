if status is-interactive

    set fish_greeting

    export EDITOR=nvim

    # -----------------------------------------------------
    # ALIASES
    # -----------------------------------------------------

    fish_add_path /home/ezratweaver/.local/bin

    export ANDROID_HOME=/home/ezratweaver/Android/Sdk

    fish_add_path /home/ezratweaver/Android/Sdk/emulator
    fish_add_path /home/ezratweaver/Android/Sdk/platform-tools

    alias c='clear'
    alias nf='neofetch'
    alias pf='pfetch'
    alias ls='eza -a --icons'
    alias ll='eza -al --icons'
    alias l='eza -a --tree --level=1 --icons'
    alias shutdown='systemctl poweroff'
    alias v='$EDITOR'
    alias sv='sudo -E $EDITOR'

    alias nx-rebuild="sudo nixos-rebuild switch --flake /etc/nixos#ezratweaver"
    alias nx-update="cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#ezratweaver"
    alias nx-rollback="sudo nixos-rebuild switch --rollback"
    alias nx-generations="sudo nixos-rebuild list-generations"
    alias nx-edit="sudo -E nvim /etc/nixos/configuration.nix"
    alias nx-dir="cd /etc/nixos/"

    alias vfzf='fzf --height=70% --layout=reverse --info=inline --border --margin=1 --padding=1 | xargs -r $EDITOR'
    alias cdf='cd ~ && cd $(find . -type d -print | fzf)'

    alias ts='~/dotfiles/scripts/snapshot.sh'
    alias matrix='cmatrix'
    alias wifi='nmtui'
    alias od='~/private/onedrive.sh'
    alias rw='~/dotfiles/waybar/reload.sh'
    alias winclass="xprop | grep 'CLASS'"
    alias dot="cd ~/dotfiles"
    alias cleanup='~/dotfiles/scripts/cleanup.sh'
    alias ml4w='~/dotfiles/apps/ML4W_Welcome-x86_64.AppImage'

    alias bluetooth="bluetuith"

    alias airplane-on="rfkill block all"
    alias airplane-off="rfkill unblock all"
    alias wifi-on="rfkill unblock 1"
    alias wifi-off="rfkill block 1"
    alias bluetooth-on="rfkill unblock 0"
    alias bluetooth-off="rfkill block 0"

    alias gb='go build'
    alias p="python"

    alias fixmon="xset -dpms"

    function cd --argument dir
        if [ dir = "" ]
            z $HOME
        else
            z $dir
        end
    end

    alias cdi="zi"

    alias gs="git status"
    alias ga="git add"
    alias gam="git commit --amend --no-edit"
    alias game="git commit --amend"
    alias gc="git commit -m"
    alias gp="git push"
    alias gpf="git push --force-with-lease"
    alias gr="git restore"
    alias gpl="git pull"
    alias gst="git stash"
    alias gsp="git stash; git pull"
    alias gcheck="git checkout"

    zoxide init fish | source

end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH $PATH /home/ezratweaver/go/bin

# Fish color scheme
set -U fish_color_autosuggestion brblack
set -U fish_color_cancel \-r
set -U fish_color_command blue
set -U fish_color_comment red
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end green
set -U fish_color_error brred
set -U fish_color_escape brcyan
set -U fish_color_history_current \-\-bold
set -U fish_color_host normal
set -U fish_color_host_remote yellow
set -U fish_color_normal normal
set -U fish_color_operator brcyan
set -U fish_color_param cyan
set -U fish_color_quote yellow
set -U fish_color_redirection cyan\e\-\-bold
set -U fish_color_search_match bryellow\e\-\-background\=brblack
set -U fish_color_selection white\e\-\-bold\e\-\-background\=brblack
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path \-\-underline

# Pager colors
set -U fish_pager_color_completion normal
set -U fish_pager_color_description yellow\e\-i
set -U fish_pager_color_prefix normal\e\-\-bold\e\-\-underline
set -U fish_pager_color_progress brwhite\e\-\-background\=cyan
set -U fish_pager_color_selected_background \-r
