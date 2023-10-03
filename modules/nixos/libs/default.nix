{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.libs;
in {
  options.amaali7.libs = with types; {
    enable = mkBoolOpt false "Whether or not to enable libs.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ libvterm zlib libtool ];
  };
}
