{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.web.telegram;
in {
  options.amaali7.web.telegram = with types; {
    enable = mkBoolOpt false "Whether or not to enable telegram.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tdlib
      whatsapp-for-linux
      tdesktop
    ];
  };
}
