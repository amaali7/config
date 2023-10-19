{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.assembly;
in {
  options.amaali7.develop.assembly = with types; {
    enable = mkBoolOpt false "Whether or not to enable assembly.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    nasm
    ];
  };
}
