{ options, lib, config, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.apps.xonotic;
in {
  options.amaali7.apps.xonotic = with types; {
    enable = mkBoolOpt false "Whether or not to enable newvide.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      xonotic-glx
    ];
  };
}
