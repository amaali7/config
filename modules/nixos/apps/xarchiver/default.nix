{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.apps.xarchiver;
in {
  options.amaali7.apps.xarchiver = with types; {
    enable = mkBoolOpt false "Whether or not to enable xarchiver.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ xarchiver ]; };
}
