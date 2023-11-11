{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.apps.qemu;
in {
  options.amaali7.apps.qemu = with types; {
    enable = mkBoolOpt false "Whether or not to enable qemu.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        qemu_full
        qemu-utils
      ];
  };
}
