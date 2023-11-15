{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.archetypes.server;
in
{
  options.amaali7.archetypes.server = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the server archetype.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      suites = {
        # common-slim = enabled;
      };

      cli-apps.neovim = enabled;
      tools.git = enabled;

    };
  };
}
