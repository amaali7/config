{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.web.matrix;
in {
  options.amaali7.web.matrix = with types; {
    enable = mkBoolOpt false "Whether or not to enable Matrix.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ element-desktop ];
  };
}
