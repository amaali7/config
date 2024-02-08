{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.apps.twitter;
in
{
  options.amaali7.apps.twitter = with types; {
    enable = mkBoolOpt false "Whether or not to enable Twitter.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs.amaali7; [ twitter ]; };
}
