{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.desktop.addons.term;
in
{
  options.amaali7.desktop.addons.term = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
    pkg = mkOpt package pkgs.foot "The terminal to install.";
  };

  config = mkIf cfg.enable { environment.systemPackages = [ cfg.pkg ]; };
}
