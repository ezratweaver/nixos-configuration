{ ... }:

{
  xdg.configFile."mimeapps.list".force = true;

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # --- Image Viewer (Qimgv) ---
      "image/png" = [ "org.gnome.Loupe.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];

      # --- Video Player (Clapper) ---
      "video/x-matroska" = [ "com.github.rafostar.Clapper.desktop" ]; # .mkv
      "video/mp4" = [ "com.github.rafostar.Clapper.desktop" ]; # .mp4
      "video/quicktime" = [ "com.github.rafostar.Clapper.desktop" ]; # .mov
      "video/x-flv" = [ "com.github.rafostar.Clapper.desktop" ]; # .flv
      "video/webm" = [ "com.github.rafostar.Clapper.desktop" ]; # .webm
      "video/mpeg" = [ "com.github.rafostar.Clapper.desktop" ]; # .mpg, .mpeg
      "video/x-ms-wmv" = [ "com.github.rafostar.Clapper.desktop" ]; # .wmv
      "video/x-msvideo" = [ "com.github.rafostar.Clapper.desktop" ]; # .avi
      "video/any" = [ "com.github.rafostar.Clapper.desktop" ];

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
