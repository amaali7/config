{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.binary;
in {
  options.amaali7.develop.binary = with types; {
    enable = mkBoolOpt false "Whether or not to enable binary.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with pkgs.amaali7; [ binutils ];
  };
}
