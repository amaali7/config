{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.toolkit.common;
in {
  options.amaali7.develop.toolkit.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ jq openssl editorconfig-core-c ];
  };
}
