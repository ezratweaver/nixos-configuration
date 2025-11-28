{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    gtk3 = {
      bookmarks = [
        "file://${config.xdg.userDirs.documents}"
        "file://${config.xdg.userDirs.download}"
        "file:///home/ezratweaver/Code"
        "file:///home/ezratweaver/Screenshots/"
      ];
    };

  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "video/x-matroska" = [ "com.github.rafostar.Clapper.desktop" ]; # .mkv
      "video/mp4" = [ "com.github.rafostar.Clapper.desktop" ]; # .mp4
      "video/quicktime" = [ "com.github.rafostar.Clapper.desktop" ]; # .mov
      "video/x-flv" = [ "com.github.rafostar.Clapper.desktop" ]; # .flv
      "video/webm" = [ "com.github.rafostar.Clapper.desktop" ]; # .webm
      "video/mpeg" = [ "com.github.rafostar.Clapper.desktop" ]; # .mpg, .mpeg
      "video/x-ms-wmv" = [ "com.github.rafostar.Clapper.desktop" ]; # .wmv
      "video/x-msvideo" = [ "com.github.rafostar.Clapper.desktop" ]; # .avi

      "video/any" = [ "com.github.rafostar.Clapper.desktop" ];
    };
  };

  home.sessionVariables.GTK_THEME = "Adwaita-dark";

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };
  };
}
