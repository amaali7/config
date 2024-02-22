{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.suites.games;
  apps = {
    openra = enabled;
    xonotic = enabled;
  };
in
{
  options.amaali7.suites.games = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable common games configuration.";
  };

  config = mkIf cfg.enable { amaali7 = { inherit apps; }; };
}
