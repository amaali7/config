{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.desktop.i3wm;
in
{
  options.amaali7.desktop.i3wm = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable I3wm .";
  };

  config = mkIf cfg.enable {
    services.xserver.windoManager.i3 = enabled;
    environment.systemPackages = with pkgs; [
      i3lock
      autotiling-rs
    ];
  };
} 
