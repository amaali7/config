{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.desktop.addons.foot;
in
{
  options.amaali7.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
  };

  config = mkIf cfg.enable {
    amaali7.desktop.addons.term = {
      enable = true;
      pkg = pkgs.foot;
    };

    amaali7.home.configFile."foot/foot.ini".source = ./foot.ini;
  };
}
