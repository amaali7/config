{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.groups.common;
in {
  options.amaali7.groups.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable groups common.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      libs = enabled;
      common = enabled;
      # common.enable = true;
      desktop.common = enabled;
      media.common = enabled;
      security.doas = enabled;
      # tools.audio = enabled;
    };
  };
}
