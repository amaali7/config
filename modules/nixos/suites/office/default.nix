{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.suites.office;
in
{
  options.amaali7.suites.office = with types; {
    enable = mkBoolOpt false "Whether or not to enable office configuration.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.amaali7.list-iommu
    ];

    amaali7 = {
      apps = {
        libreoffice = enabled;
      };
    };
  };
}
