{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.apps.pitivi;
in
{
  options.amaali7.apps.pitivi = with types; {
    enable = mkBoolOpt false "Whether or not to enable Pitivi.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ pitivi ]; };
}
