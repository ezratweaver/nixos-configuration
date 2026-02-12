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
      "app.zen_browser.zen"
    ];

    update.onActivation = true;
  };
}
