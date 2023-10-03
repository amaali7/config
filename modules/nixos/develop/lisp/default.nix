{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.lisp;
in {
  options.amaali7.develop.lisp = with types; {
    enable = mkBoolOpt false "Whether or not to enable lisp.";
  };

  config =
    mkIf cfg.enable { environment.systemPackages = with pkgs; [ gcl sbcl ]; };
}
