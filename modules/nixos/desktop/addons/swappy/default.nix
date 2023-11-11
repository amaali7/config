{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.desktop.addons.swappy;
in
{
  options.amaali7.desktop.addons.swappy = with types; {
    enable =
      mkBoolOpt false "Whether to enable Swappy in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ swappy ];

    amaali7.home.configFile."swappy/config".source = ./config;
    amaali7.home.file."Pictures/screenshots/.keep".text = "";
  };
}
