{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.office.zathura;
in {
  options.amaali7.office.zathura = with types; {
    enable = mkBoolOpt false "Whether or not to enable zathura.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; with pkgs.amaali7; [ zathura ];
  };
}
