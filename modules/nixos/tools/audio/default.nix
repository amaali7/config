{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.audio;
in {
  options.amaali7.tools.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        cava
        sptlrx
      ];
  };
}
