{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.suites.art;
in
{
  options.amaali7.suites.art = with types; {
    enable = mkBoolOpt false "Whether or not to enable art configuration.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      apps = {
        gimp = enabled;
        inkscape = enabled;
      };
    };
  };
}
