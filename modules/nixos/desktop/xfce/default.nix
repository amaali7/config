{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.desktop.xfce;
in {
  options.amaali7.desktop.xfce = with types; {
    enable = mkBoolOpt false "Whether or not to enable xfce.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.xfce;
      with pkgs.amaali7; [
        xfce4-power-manager
        thunar
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
        tumbler
        ristretto
      ];
  };
}
