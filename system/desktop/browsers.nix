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
        DefaultSearchProviderSearchURL = "https://www.google.com/search?q={searchTerms}";
        DefaultSearchProviderName = "Google";
        DefaultSearchProviderKeyword = "google.com";

        ExtensionInstallForcelist = map (extension: extension.id) [
          {
            name = "Tabliss";
            id = "hipekcciheckooncpjeljhnekcoolahp";
          }
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
        ];
      };
}
