{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.web.altair;
in {
  options.amaali7.develop.web.altair = with types; {
    enable = mkBoolOpt false "Whether or not to enable altair.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ altair ]; };
}
