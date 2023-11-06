{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.embdedded;
in {
  options.amaali7.develop.embdedded = with types; {
    enable = mkBoolOpt false "Whether or not to enable embdedded";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        pkgsCross.avr.buildPackages.gcc
      ];
  };
}
