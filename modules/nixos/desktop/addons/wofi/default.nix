{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.desktop.addons.wofi;
in
{
  options.amaali7.desktop.addons.wofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wofi wofi-emoji ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # amaali7.home.configFile."foot/foot.ini".source = ./foot.ini;
    amaali7.home.configFile."wofi/config".source = ./config;
    amaali7.home.configFile."wofi/style.css".source = ./style.css;
  };
}
