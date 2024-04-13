{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.apps.emacs;
in {
  options.amaali7.apps.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable altair.";
  };

  config = mkIf cfg.enable {

    services = {
      emacs = {
        defaultEditor = true;
        enable = true;
        package = pkgs.emacs29;
      };
    };
    environment.systemPackages = with pkgs; [
      pandoc
      graphviz
      markdownlint-cli2
      proselint
      multimarkdown
    ];
  };
}
