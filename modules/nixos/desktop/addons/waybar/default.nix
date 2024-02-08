{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.desktop.addons.waybar;
in
{
  options.amaali7.desktop.addons.waybar = with types; {
    enable =
      mkBoolOpt false "Whether to enable Waybar in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ waybar ];

    amaali7.home.configFile."waybar/config".source = ./config;
    amaali7.home.configFile."waybar/style.css".source = ./style.css;
  };
}
