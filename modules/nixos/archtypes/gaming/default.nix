{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.archetypes.gaming;
in
{
  options.amaali7.archetypes.gaming = with types; {
    enable = mkBoolOpt false "Whether or not to enable the gaming archetype.";
  };

  config = mkIf cfg.enable {
    amaali7.suites = {
      common = enabled;
      desktop = enabled;
      games = enabled;
      social = enabled;
      media = enabled;
    };
  };
}
