{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.toolkit.docker;
in {
  options.amaali7.develop.toolkit.docker = with types; {
    enable = mkBoolOpt false "Whether or not to enable docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker = { enable = true; };
    environment.systemPackages = with pkgs; [ docker-compose ];
  };
}
