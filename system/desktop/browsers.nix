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
    ../../home/dotfiles/brave/policies.json;
}
