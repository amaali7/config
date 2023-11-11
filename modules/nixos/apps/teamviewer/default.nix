{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.apps.teamviewer;
in {
  options.amaali7.apps.teamviewer = with types; {
    enable = mkBoolOpt false "Whether or not to enable teamviewer.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with pkgs.amaali7; [ teamviewer ];
  };
}
