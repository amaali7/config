{ lib, config, inputs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.amaali7) enabled;

  cfg = config.amaali7.cli-apps.home-manager;
in
{
  options.amaali7.cli-apps.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  config = mkIf cfg.enable {
    programs.home-manager = enabled;

  };
}
