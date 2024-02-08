{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.apps.firefox;
  defaultSettings = {
    "browser.aboutwelcome.enabled" = false;
    "browser.meta_refresh_when_inactive.disabled" = true;
    "browser.startup.homepage" = "https://hamho.me";
    "browser.bookmarks.showMobileBookmarks" = true;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.ssb.enabled" = true;
  };
in
{
  options.amaali7.apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable Firefox.";
    extraConfig =
      mkOpt str "" "Extra configuration for the user profile JS file.";
    userChrome =
      mkOpt str "" "Extra configuration for the user chrome CSS file.";
    settings = mkOpt attrs defaultSettings "Settings to apply to the profile.";
  };

  config = mkIf cfg.enable {
    amaali7.desktop.addons.firefox-nordic-theme = enabled;

    # services.gnome.gnome-browser-connector.enable = config.amaali7.desktop.gnome.enable;

    amaali7.home = {
      # file = {
      #   ".mozilla/native-messaging-hosts/com.dannyvankooten.browserpass.json".source = "${pkgs.browserpass}/lib/mozilla/native-messaging-hosts/com.dannyvankooten.browserpass.json";
      #
      #   ".mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json".source = mkIf config.amaali7.desktop.gnome.enable "${pkgs.chrome-gnome-shell}/lib/mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json";
      # };
      #
      extraOptions = {
        programs.firefox = {
          enable = true;
          package = pkgs.firefox.override (
            {
              cfg = {
                enableBrowserpass = true;
                # enableGnomeExtensions = config.amaali7.desktop.gnome.enable;
              };

              # extraNativeMessagingHosts =
              #   optional
              #     config.amaali7.desktop.gnome.enable
              #     pkgs.gnomeExtensions.gsconnect;
            }
          );

          profiles.${config.amaali7.user.name} = {
            inherit (cfg) extraConfig userChrome settings;
            id = 0;
            name = config.amaali7.user.name;
          };
        };
      };
    };
  };
}
