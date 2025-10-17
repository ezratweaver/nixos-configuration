{ pkgs, ... }:
let
  waylandChromiumArgs = [
    "--enable-features=UseOzonePlatform"
    "--ozone-platform=wayland"
    "--enable-wayland-ime"
  ];
  braveExtensionForcelist = [
    {
      name = "extension-1";
      id = "hipekcciheckooncpjeljhnekcoolahp";
    }
    {
      name = "extension-2";
      id = "nngceckbapebfimnlniiiahkandclblb";
    }
    {
      name = "extension-3";
      id = "dbepggeogbaibhgnhhndojpepiihcmeb";
    }
    {
      name = "extension-4";
      id = "mnjggcdmjocbbbhaepdhchncahnbgone";
    }
    {
      name = "Tokyo Night Storm Theme";
      id = "pgbjifpikialeahbdendkjioeafbmfkn";
    }
    {
      name = "Minimal Youtube";
      id = "imnffafnaoooaedkhappfhomnnpigogk";
    }
    {
      name = "Remove Youtube Shorts";
      id = "mgngbgbhliflggkamjnpdmegbkidiapm";
    }
  ];
  braveManagedPolicy = {
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

    ExtensionInstallForcelist = map (extension: extension.id) braveExtensionForcelist;
  };
  braveManagedPolicyFile =
    (pkgs.formats.json { }).generate "brave-managed-policy.json"
      braveManagedPolicy;
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

  environment.etc."/brave/policies/managed/GroupPolicy.json".source = braveManagedPolicyFile;
}
