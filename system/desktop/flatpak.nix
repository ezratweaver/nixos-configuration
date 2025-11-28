{ pkgs, ... }:

let
  flatpaks = [
    "org.gnome.dspy"
    "re.sonny.Workbench"
  ];
in
{
  services.flatpak.enable = true;

  system.userActivationScripts.flatpakManagement = {
    text = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo

      for app in ${toString flatpaks}; do
        echo "Ensuring $app is installed."
        ${pkgs.flatpak}/bin/flatpak install -y flathub $app
      done

      ${pkgs.flatpak}/bin/flatpak uninstall --unused -y

      ${pkgs.flatpak}/bin/flatpak update -y
    '';
  };

  environment.systemPackages = with pkgs; [
    flatpak-builder # For developing with flatpaks
  ];
}
