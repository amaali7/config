{ config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.tools.attic;
in
{
  options.amaali7.tools.attic = {
    enable = mkEnableOption "Attic";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      attic
    ];
  };
}
