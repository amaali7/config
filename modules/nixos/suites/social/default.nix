{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.suites.social;
in
{
  options.amaali7.suites.social = with types; {
    enable = mkBoolOpt false "Whether or not to enable social configuration.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      apps = {
        # element = enabled;
        telegram = enabled;
        whatsapp = enabled;
      };
    };
  };
}
