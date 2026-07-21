{ ... }:

{
  # Start a single, shared ssh-agent per login so keys added with `ssh-add`
  # in one terminal are available in every terminal.
  programs.ssh.startAgent = true;

  # Automatically add a key to the agent the first time it is used, so you
  # enter its passphrase once per login instead of running `ssh-add` manually.
  programs.ssh.extraConfig = ''
    AddKeysToAgent yes
  '';
}
