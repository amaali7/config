{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.vnc;
in {
  options.amaali7.tools.vnc = with types; {
    enable = mkBoolOpt false "Whether or not to enable vnc.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with pkgs.amaali7; [ teamviewer ];
  };
}
