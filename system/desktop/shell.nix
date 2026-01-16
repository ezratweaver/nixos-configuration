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
  ];
}
