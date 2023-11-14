{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.apps.whatsapp;
in {
  options.amaali7.apps.whatsapp = with types; {
    enable = mkBoolOpt false "Whether or not to enable telegram.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      whatsapp-for-linux
    ];
  };
}
