{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave
    chromium
    helium
  ];

  environment.etc."/chromium/policies/managed/policy.json".source =
    (pkgs.formats.json { }).generate "policy.json"
      {
        AutofillEnabled = false;
        AutofillProfileEnabled = false;
        AutofillCreditCardEnabled = false;
        PasswordManagerEnabled = false;
        MetricsReportingEnabled = false;
        CrashReportingEnabled = false;
        BackgroundModeEnabled = false;
        DnsOverHttpsMode = "secure";
        PromotionalTabsEnabled = false;
        PrivacySandboxPromptEnabled = false;

        DefaultSearchProviderEnabled = true;
        DefaultSearchProviderSearchURL = "https://startpage.com/sp/search?q={searchTerms}";
        DefaultSearchProviderSuggestURL = "https://www.startpage.com/osuggestions?q={searchTerms}";
        DefaultSearchProviderName = "StartPage";
        DefaultSearchProviderKeyword = "startpage.com";

        ExtensionInstallForcelist = map (extension: extension.id) [
          {
            name = "Bitwarden";
            id = "nngceckbapebfimnlniiiahkandclblb";
          }
          {
            name = "Vimium";
            id = "dbepggeogbaibhgnhhndojpepiihcmeb";
          }
          {
            name = "SponserBlock for Youtube";
            id = "mnjggcdmjocbbbhaepdhchncahnbgone";
          }
          {
            name = "Uninternet";
            id = "ihgeijoonjmdfkamhpgoedplnmbencgd";
          }
          {
            name = "Remove Youtube Shorts";
            id = "mgngbgbhliflggkamjnpdmegbkidiapm";
          }
          {
            name = "Dark Theme for Google Chrome";
            id = "annfbnbieaamhaimclajlajpijgkdblo";
          }
        ];
      };

  environment.etc."/brave/policies/managed/GroupPolicy.json".source =
    (pkgs.formats.json { }).generate "brave-managed-policy.json"
      {
        BraveRewardsDisabled = true;
        BraveWalletDisabled = true;
        BraveAIChatEnabled = false;
        AutofillEnabled = false;
        AutofillProfileEnabled = false;
        AutofillCreditCardEnabled = false;
        PasswordManagerEnabled = false;
        MetricsReportingEnabled = false;
        CrashReportingEnabled = false;
        BackgroundModeEnabled = false;
        DnsOverHttpsMode = "secure";
        PromotionalTabsEnabled = false;
        PrivacySandboxPromptEnabled = false;

        DefaultSearchProviderEnabled = true;
        DefaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
        DefaultSearchProviderName = "DuckDuckGo";
        DefaultSearchProviderKeyword = "duckduckgo.com";

        ExtensionInstallForcelist = map (extension: extension.id) [
          {
            name = "Bitwarden";
            id = "nngceckbapebfimnlniiiahkandclblb";
          }
          {
            name = "Vimium";
            id = "dbepggeogbaibhgnhhndojpepiihcmeb";
          }
          {
            name = "SponserBlock for Youtube";
            id = "mnjggcdmjocbbbhaepdhchncahnbgone";
          }
          {
            name = "Uninternet";
            id = "ihgeijoonjmdfkamhpgoedplnmbencgd";
          }
          {
            name = "Remove Youtube Shorts";
            id = "mgngbgbhliflggkamjnpdmegbkidiapm";
          }
          {
            name = "Dark Theme for Google Chrome";
            id = "annfbnbieaamhaimclajlajpijgkdblo";
          }
        ];
      };

  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      Preferences = {
        # FASTFOX – Performance Tweaks
        "gfx.content.skia-font-cache-size" = 32;
        "gfx.canvas.accelerated.cache-items" = 32768;
        "gfx.canvas.accelerated.cache-size" = 4096;
        "webgl.max-size" = 16384;

        # Disk Cache
        "browser.cache.disk.enable" = false;

        # Memory Cache
        "browser.cache.memory.capacity" = 131072;
        "browser.cache.memory.max_entry_size" = 20480;
        "browser.sessionhistory.max_total_viewers" = 4;
        "browser.sessionstore.max_tabs_undo" = 10;

        # Media Cache
        "media.memory_cache_max_size" = 262144;
        "media.memory_caches_combined_limit_kb" = 1048576;
        "media.cache_readahead_limit" = 600;
        "media.cache_resume_threshold" = 300;

        # Image Cache
        "image.cache.size" = 10485760;
        "image.mem.decode_bytes_at_a_time" = 65536;

        # Network
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.request.max-start-delay" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheEntries" = 10000;
        "network.dnsCacheExpiration" = 3600;
        "network.ssl_tokens_cache_capacity" = 10240;

        # Disable Speculative Loading
        "network.http.speculative-parallel-limit" = 0;
        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;
        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.places.speculativeConnect.enabled" = false;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;

        # SECUREFOX – Privacy and Security
        "browser.contentblocking.category" = "strict";
        "privacy.trackingprotection.allow_list.baseline.enabled" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;

        # OCSP & Certificates
        "security.OCSP.enabled" = 0;
        "security.csp.reporting.enabled" = false;

        # SSL / TLS
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.enable_0rtt_data" = false;

        # Disk Avoidance
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.sessionstore.interval" = 60000;

        # Shutdown & Sanitizing
        "privacy.history.custom" = true;
        "browser.privatebrowsing.resetPBM.enabled" = true;

        # Search / URL Bar
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.quicksuggest.enabled" = false;
        "browser.urlbar.groupLabels.enabled" = false;
        "browser.formfill.enable" = false;
        "network.IDN_show_punycode" = true;

        # Passwords
        "signon.formlessCapture.enabled" = false;
        "signon.privateBrowsingCapture.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "editor.truncate_user_pastes" = false;

        # Mixed Content / Cross-Site
        "security.mixed_content.block_display_content" = true;
        "pdfjs.enableScripting" = false;

        # Extensions
        "extensions.enabledScopes" = 5;

        # Headers / Referers
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        # Containers
        "privacy.userContext.ui.enabled" = true;

        # Safe Browsing
        "browser.safebrowsing.downloads.remote.enabled" = false;

        # Mozilla Network / Permissions
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "geo.provider.network.url" = "https://beacondb.net/v1/geolocate";
        "browser.search.update" = false;
        "permissions.manager.defaultsUrl" = "";
        "extensions.getAddons.cache.enabled" = false;

        # Telemetry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "datareporting.usage.uploadEnabled" = false;

        # Experiments
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        # Crash Reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;

        # PESKYFOX – UI Cleanup
        "browser.privatebrowsing.vpnpromourl" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.profiles.enabled" = true;

        # Theme / UI
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.privateWindowSeparation.enabled" = false;

        # AI Features
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.ml.linkPreview.enabled" = false;

        # Fullscreen Notice
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.timeout" = 0;

        # URL Bar
        "browser.urlbar.trending.featureGate" = false;

        # New Tab Page
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;

        # Downloads
        "browser.download.manager.addToRecentDocs" = false;

        # PDF
        "browser.download.open_pdf_attachments_inline" = true;

        # Tabs and Menus
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;

        # Personal preferences
        "browser.fullscreen.autohide" = false;
        "sidebar.verticalTabs" = true;
        "browser.tabs.tabmanager.enabled" = false;
        "ui.systemUsesDarkTheme" = 1;
        "browser.toolbars.bookmarks.visibility" = "always";
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "signon.rememberSignons" = false;
        "ui.key.menuAccessKeyFocuses" = false;
      };
    };
  };

}
