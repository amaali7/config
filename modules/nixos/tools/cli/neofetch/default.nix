{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.cli.neofetch;
in {
  options.amaali7.tools.cli.neofetch = with types; {
    enable = mkBoolOpt false "Whether or not to enable neofetch.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with pkgs.amaali7; [ neofetch ];
  };
}
