{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.suites.emulation;
in {
  options.amaali7.suites.emulation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable emulation configuration.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      apps = {
        qemu = enabled;
        yuzu = enabled;
        pcsx2 = enabled;
      };
    };
  };
}
