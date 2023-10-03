{ options, config, lib, pkgs, ... }:

with lib; with lib.amaali7;
let cfg = config.amaali7.develop.rust;
in {
  options.amaali7.develop.rust = with types; {
    enable = mkBoolOpt false "Whether or not to enable rust.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rustup
      diesel-cli
      sqlite
      sqlite.dev
    ];
  };
}
