{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.apps.tartube;
in {
  options.amaali7.apps.altair = with types; {
    enable = mkBoolOpt false "Whether or not to enable tartube.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ tartube-yt-dlp ]; };
}
