{ zen, pkgs, ... }:
{
  imports = [
    zen.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;
    profiles = {
      personal = {
        name = "Personal";
        isDefault = true;
        settings = {
          # --- Privacy Settings ---
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;
          "privacy.donottrackheader.enabled" = true;
          "privacy.globalprivacycontrol.was_ever_enabled" = true;
          "network.dns.disablePrefetch" = true;
          "network.http.speculative-parallel-limit" = 0;
          "network.predictor.enabled" = false;
          "network.prefetch-next" = false;

          # --- Autofill Disable ---
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "signon.rememberSignons" = false;

          # --- Telemetry/tracking Disable ---
          "app.shield.optoutstudies.enabled" = false;
          "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;

          # --- Zen Specific ---
          "zen.welcome-screen.seen" = true;
          "zen.themes.updated-value-observer" = true;
        };
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          vimium
          sponsorblock
        ];
        search = {
          force = true;
          default = "Startpage";
          engines = {
            Startpage = {
              name = "Startpage";
              urls = [ { template = "https://www.startpage.com/sp/search?query={searchTerms}"; } ];
              icon = "https://www.startpage.com/favicon.ico";
              definedAliases = [ "@sp" ];
            };
            Gemini = {
              name = "Gemini";
              urls = [
                {
                  template = "https://gemini.google.com/app?q={searchTerms}";
                }
              ];
              icon = "https://gemini.google.com/favicon.ico";
              definedAliases = [ "@gem" ];
            };
          };
        };
      };
    };

    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      BackgroundAppUpdates = false;
      DnsOverHttps = {
        Mode = "enabled";
      };
      ExtensionSettings = {
        "myallychou@gmail.com" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
        };
      };
    };
  };
}
