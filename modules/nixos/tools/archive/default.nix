{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.archive;
in {
  options.amaali7.tools.archive = with types; {
    enable = mkBoolOpt false "Whether or not to enable archive.";
  };

  config = mkIf cfg.enable {
    amaali7.apps.xarchiver = enabled;
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        unzip
        rar
        zstd
        p7zip
      ];
  };
}
