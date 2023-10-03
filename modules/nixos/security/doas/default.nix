{ options, config, pkgs, lib, ... }:

with lib; with lib.amaali7;
let cfg = config.amaali7.security.doas;
in {
  options.amaali7.security.doas = {
    enable = mkBoolOpt false "Whether or not to replace sudo with doas.";
  };

  config = mkIf cfg.enable {
    # Disable sudo
    security.sudo.enable = false;

    # Enable and configure `doas`.
    security.doas = {
      enable = true;
      extraRules = [{
        users = [ config.amaali7.user.name ];
        noPass = true;
        keepEnv = true;
      }];
    };

    # Add an alias to the shell for backward-compat and convenience.
    environment.shellAliases = { sudo = "doas"; };
  };
}
