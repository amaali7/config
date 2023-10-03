{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.web.torrent;
in {
  options.amaali7.web.torrent = with types; {
    enable = mkBoolOpt false "Whether or not to enable torrent.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ transmission-gtk ];
  };
}
