{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.hardware;
in {
  options.amaali7.tools.hardware = with types; {
    enable = mkBoolOpt false "Whether or not to enable hardware.";
  };

  config = mkIf cfg.enable {
    services.asusd = enabled;
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        minicom
        openocd
        nixgl.nixGLIntel
        libGL
        libudev-zero
      ];
  };
}
