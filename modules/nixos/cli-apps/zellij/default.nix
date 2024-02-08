{ lib
, config
, pkgs
, ...
}:
with lib;
with lib.amaali7; let
  cfg = config.amaali7.cli-apps.zellij;
in
{
  options.amaali7.cli-apps.zellij = {
    enable = mkEnableOption "zellij";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zellij
    ];
  };
}
