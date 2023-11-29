{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.apps.ani-cli;
in {
  options.amaali7.apps.ani-cli = with types; {
    enable = mkBoolOpt false "Whether or not to enable ani-cli.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs.amaali7; [ ani-cli ]; };
}
