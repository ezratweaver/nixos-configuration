{ ... }:

{
  xdg.configFile."mimeapps.list".force = true;

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # --- Image Viewer (Qimgv) ---
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];

      # --- Video Player (Celluloid) ---
      "video/x-matroska" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .mkv
      "video/mp4" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .mp4
      "video/quicktime" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .mov
      "video/x-flv" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .flv
      "video/webm" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .webm
      "video/mpeg" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .mpg, .mpeg
      "video/x-ms-wmv" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .wmv
      "video/x-msvideo" = [ "io.github.celluloid_player.Celluloid.desktop" ]; # .avi
      "video/any" = [ "io.github.celluloid_player.Celluloid.desktop" ];

      # --- Browser (Helium) ---
      "x-scheme-handler/http" = [ "helium.desktop" ];
      "x-scheme-handler/https" = [ "helium.desktop" ];
      "x-scheme-handler/about" = [ "helium.desktop" ];
      "x-scheme-handler/unknown" = [ "helium.desktop" ];
      "text/html" = [ "helium.desktop" ];
      "application/xhtml+xml" = [ "helium.desktop" ];
      "application/x-extension-htm" = [ "helium.desktop" ];
      "application/x-extension-html" = [ "helium.desktop" ];
      "application/x-extension-shtml" = [ "helium.desktop" ];
      "application/x-extension-xhtml" = [ "helium.desktop" ];
      "application/x-extension-xht" = [ "helium.desktop" ];

      # --- PDF Viewer (Helium) ---
      "application/pdf" = [ "helium.desktop" ];

      # --- Protocol Handlers ---
      "x-scheme-handler/magnet" = [ "org.qbittorrent.qBittorrent.desktop" ];
      "x-scheme-handler/anytype" = [ "anytype.desktop" ];
      "x-scheme-handler/sgnl" = [ "signal.desktop" ];
      "x-scheme-handler/signalcaptcha" = [ "signal.desktop" ];

      # --- Figma OAuth ---
      "x-scheme-handler/figma" = [ "figma-linux.desktop" ];
    };
  };
}
