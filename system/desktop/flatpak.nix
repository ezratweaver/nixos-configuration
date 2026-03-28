{ ... }:

{
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "org.gnome.dspy"
      "re.sonny.Workbench"
      "com.collaboraoffice.Office"
    ];

    update.onActivation = true;
  };
}
