{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.javascript;
in {
  options.amaali7.develop.javascript = with types; {
    enable = mkBoolOpt false "Whether or not to enable javascript.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nodePackages.node-gyp nodejs_20 ];
  };
}
