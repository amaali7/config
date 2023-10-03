{ options, config, lib, pkgs, ... }:

with lib; with lib.amaali7;
let cfg = config.amaali7.web;
in {
  options.amaali7.web = with types; {
    enable = mkBoolOpt false "Whether or not to enable brave.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ chromium ];
    amaali7 = {
      web = {
        brave = enabled;
        matrix = enabled;
        firefox = enabled;
        telegram = enabled;
        torrent = enabled;
      };
    };
  };
}
