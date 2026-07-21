{ ... }:

{
  environment.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/gcr/ssh";

  programs.ssh.extraConfig = ''
    # Add a key to the agent the first time it is used (gnome-keyring then
    # offers to remember its passphrase in the keyring).
    AddKeysToAgent yes

    # Keys with non-default filenames are not auto-discovered. List them here to
    # have SSH try them for every host, alongside the built-in id_* defaults.
    Host *
        IdentityFile ~/.ssh/aur
  '';
}
