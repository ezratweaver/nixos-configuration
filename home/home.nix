{ config, pkgs, ... }:
{
  home.stateVersion = "24.05";

  home.file = {
    ".config/hypr/" = {
      source = ./dotfiles/hypr;
      recursive = true;
    };

    ".config/nvim/" = {
      source = ./dotfiles/nvim;
      recursive = true;
    };

    ".config/fish/" = {
      source = ./dotfiles/fish;
      recursive = true;
    };

    ".config/kitty/" = {
      source = ./dotfiles/kitty;
      recursive = true;
    };

    ".config/rofi/" = {
      source = ./dotfiles/rofi;
      recursive = true;
    };

    ".config/waybar/" = {
      source = ./dotfiles/waybar;
      recursive = true;
    };

    ".config/swaync/" = {
      source = ./dotfiles/swaync;
      recursive = true;
    };
  };

  programs.home-manager.enable = true;

  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        # UI preferences
        "browser.fullscreen.autohide" = false;
        "sidebar.verticalTabs" = true;
        "browser.tabs.tabmanager.enabled" = false;
        "ui.systemUsesDarkTheme" = 1;
        "browser.toolbars.bookmarks.visibility" = "always";

        # Enhanced tracking protection
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;

        # DNS over HTTPS
        "network.trr.mode" = 2;
        "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";

        # Disable auto-fill
        "browser.formfill.enable" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        # Disable password manager
        "signon.rememberSignons" = false;

        # Security settings
        "security.tls.version.fallback-limit" = 3;
        "security.ssl.require_safe_negotiation" = true;

        # Performance vs privacy trade-offs
        "dom.battery.enabled" = false;
        "dom.gamepad.enabled" = false;

        # User agent and window size
        "privacy.spoof_english" = 2;
        "general.useragent.locale" = "en-US";

        # Telemetry and data collection
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.server" = "";
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "network.allow-experiments" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;

        # Disable alt from opening menu
        "ui.key.menuAccessKeyFocuses" = false;
      };
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
    ];
  };

  # GTK theme configuration for dark mode
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
      # Nautalis bookmarks
      bookmarks = [
        "file://${config.xdg.userDirs.documents}"
        "file://${config.xdg.userDirs.download}"
      ];
    };
  };

  # Qt theme configuration for dark mode
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  # dconf settings for GNOME applications
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      color-scheme = "prefer-dark";
    };
  };
}
