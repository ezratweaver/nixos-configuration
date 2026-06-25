{ pkgs, ... }:

let
  searchEngine = {
    name = "Brave";
    keyword = "search.brave.com";
    url = "https://search.brave.com/search?q={searchTerms}";
    iconUrl = "https://search.brave.com/favicon.ico";
    alias = "brave";
  };
in
{
  environment.systemPackages = with pkgs; [
    brave
    nur.repos.forkprince.helium-nightly

    # Vanilla browsers for testing
    firefox
    chromium
    epiphany
  ];

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
        DefaultSearchProviderSearchURL = searchEngine.url;
        DefaultSearchProviderName = searchEngine.name;
        DefaultSearchProviderKeyword = searchEngine.keyword;

        ExtensionInstallForcelist = [
          "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
          "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for Youtube
          "khncfooichmfjbepaaaebmommgaepoid" # Unhook
          "mgngbgbhliflggkamjnpdmegbkidiapm" # Remove Youtube Shorts
        ];
      };

  programs.firefox = {
    enable = true;
    # package = pkgs.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;

      SearchEngines = {
        Default = searchEngine.name;
        Add = [
          {
            Name = searchEngine.name;
            URLTemplate = searchEngine.url;
            Method = "GET";
            IconURL = searchEngine.iconUrl;
            Alias = searchEngine.alias;
          }
        ];
      };

      Preferences = {
        "browser.compactmode.show" = true;
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
