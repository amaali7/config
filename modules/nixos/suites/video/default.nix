{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.suites.video;
in
{
  options.amaali7.suites.video = with types; {
    enable = mkBoolOpt false "Whether or not to enable video configuration.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      apps = {
        pitivi = enabled;
        obs-studio = enabled;
      };
    };
  };
}
