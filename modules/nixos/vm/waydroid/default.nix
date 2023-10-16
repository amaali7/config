{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.vm.waydroid;
in {
  options.amaali7.vm.waydroid = with types; {
    enable = mkBoolOpt false "Whether or not to enable wayland.";
  };

  config = mkIf cfg.enable { virtualisation.waydroid.enable = true; };
}
