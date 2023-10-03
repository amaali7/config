{ options, config,inputs, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.web.firefox;
in {
  options.amaali7.web.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable firefox.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      firefox
      # inputs.nur.repos.wolfangaukang.vdhcoapp
    ];
  };
}
