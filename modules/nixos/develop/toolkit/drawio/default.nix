{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.toolkit.drawio;
in {
  options.amaali7.develop.toolkit.drawio = with types; {
    enable = mkBoolOpt false "Whether or not to enable drawio.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ drawio ]; };
}
