{ pkgs, ... }:
let
  waylandChromiumArgs = [
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
    "--enable-wayland-ime"
  ];
in
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    (brave.override {
      commandLineArgs = waylandChromiumArgs;
    })
    (chromium.override {
      commandLineArgs = waylandChromiumArgs;
    })
    helium
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
}
