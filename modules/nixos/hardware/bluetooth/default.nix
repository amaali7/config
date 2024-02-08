{ options, config, pkgs, lib, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.hardware.bluetooth;
in
{
  options.amaali7.hardware.bluetooth = with types; {
    enable = mkBoolOpt false "Whether or not to enable bluetooth support";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ bluez ];
    hardware.bluetooth = enabled;
  };
}
