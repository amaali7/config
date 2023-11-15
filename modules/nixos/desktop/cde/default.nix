{ options, inputs, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.desktop.cde;
in {
  options.amaali7.desktop.cde = with types; {
    enable = mkBoolOpt false "Whether or not to enable cde";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.cde = enabled;
    amaali7 = {
      desktop = {
        common-tiling = enabled;
        themes = enabled;
        xfce = enabled;
      };

      home = {
        extraOptions = {
          home.packages = with pkgs; [
            foot
            imagemagick
            sassc
            swww
          ];
        };
      };
    };
  };
}
