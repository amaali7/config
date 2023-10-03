{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.toolkit.git;
in {
  options.amaali7.develop.toolkit.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gitFull lazygit ];
  };
}
