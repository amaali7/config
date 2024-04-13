{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.comma;
in {
  options.amaali7.tools.comma = with types; {
    enable = mkBoolOpt false "Whether or not to enable comma.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        comma
        # amaali7.nix-update-index
      ];

    amaali7.home = {
      configFile = { "wgetrc".text = ""; };

      # extraOptions = { programs.nix-index.enable = true; };
    };
  };
}
