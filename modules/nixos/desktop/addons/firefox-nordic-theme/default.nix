{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.desktop.addons.firefox-nordic-theme;
  profileDir = ".mozilla/firefox/${config.amaali7.user.name}";
in
{
  options.amaali7.desktop.addons.firefox-nordic-theme = with types; {
    enable = mkBoolOpt false "Whether to enable the Nordic theme for firefox.";
  };

  config = mkIf cfg.enable {
    amaali7.apps.firefox = {
      extraConfig = builtins.readFile
        "${pkgs.amaali7.firefox-nordic-theme}/configuration/user.js";
      userChrome = ''
        @import "${pkgs.amaali7.firefox-nordic-theme}/userChrome.css";
      '';
    };
  };
}
