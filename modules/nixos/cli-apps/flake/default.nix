inputs@{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.cli-apps.flake;
in
{
  options.amaali7.cli-apps.flake = with types; {
    enable = mkBoolOpt false "Whether or not to enable flake.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      snowfallorg.flake
    ];
  };
}
