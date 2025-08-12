{
  users.users.ezratweaver = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    initialPassword = "password"; # Please use `passwd` to change this
  };
}
