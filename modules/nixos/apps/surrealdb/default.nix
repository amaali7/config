{ options, config, lib, pkgs, ... }:

with lib; with lib.amaali7;
let cfg = config.amaali7.apps.surrealdb;
in {
  options.amaali7.apps.surrealdb = with types; {
    enable = mkBoolOpt false "Whether or not to enable surrealdb.";
  };

  config = mkIf cfg.enable {
    services.surrealdb = {
      enable = true;
      port = 1238;
      userNamePath = ./username;
      passwordPath = ./password;
    };
    environment.systemPackages = with pkgs; [ surrealdb-migrations ];
  };
}
