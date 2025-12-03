{ pkgs, ... }:

{
  # Shell configuration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;

      ohMyZsh = {
        enable = true;
        plugins = [
          "gitfast"
          "ssh-agent"
        ];
      };

      shellInit = ''
        # Environment variables
        export EDITOR=nvim
        export PATH="$HOME/.local/bin:$PATH"
      '';

      interactiveShellInit = ''
        # Load zsh-autopair
        source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
        autopair-init
      '';

      shellAliases = {
        # General aliases
        c = "clear";
        cc = "claude";
        nf = "neofetch";
        shutdown = "systemctl poweroff";
        v = "$EDITOR";
        sv = "sudo -E $EDITOR";

        # File listing aliases
        ls = "eza -a --icons";
        ll = "eza -al --icons";

        # NixOS aliases
        nxs = "nix-search";
        nxrollback = "sudo nixos-rebuild switch --rollback";
        nxgenerations = "sudo nixos-rebuild list-generations";
        vnx = "nvim ~/nixos-configuration/configuration.nix";
        nxdir = "cd ~/nixos-configuration/";

        # Navigation aliases
        cdf = "cd $(find . -type d -print | command fzf)";
        cdi = "zi";

        # Git aliases
        gs = "git status";
        ga = "git add";
        gc = "git commit -m";
        gam = "git commit --amend --no-edit";
        game = "git commit --amend";
        gp = "git push";
        gpf = "git push --force-with-lease";
        gpl = "git pull";
        gr = "git restore";
        gst = "git stash";
        gsp = "git stash; git pull";
        gcheck = "git checkout";
        grs = "git restore --staged";
      };

      setOptions = [
        "AUTO_CD" # Change directory without typing cd
        "HIST_VERIFY" # Show command with history expansion to user before running it
        "SHARE_HISTORY" # Share command history data
        "HIST_IGNORE_SPACE" # Don't record commands that start with space
        "HIST_IGNORE_DUPS" # Don't record duplicates
        "COMPLETE_IN_WORD" # Complete from both ends of a word
        "PROMPT_SUBST" # Enable prompt substitution
      ];

      histSize = 10000;
    };
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.ezratweaver.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    zsh
    zoxide
    eza
    zsh-autopair
  ];
}
