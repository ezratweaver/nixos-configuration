{ pkgs, ... }:
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

  # Auto-launch fish if not already in fish and if interactive
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      if [[ $- == *i* ]] && [[ -z "$FISH_VERSION" ]] && command -v fish >/dev/null 2>&1; then
        exec fish
      fi
    '';
  };

  programs.fish.enable = true;

  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "browser.fullscreen.autohide" = false;
        "sidebar.verticalTabs" = true;
        "sidebar.verticalTabs.expandOnHover" = true;
        "browser.tabs.tabmanager.enabled" = false;
        "ui.systemUsesDarkTheme" = 1;
        "browser.toolbars.bookmarks.visibility" = "always";
        
        # Disable telemetry and data collection
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
      };
    };
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
  };

  # Configure GTK settings for dark mode
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
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
