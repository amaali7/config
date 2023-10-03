{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.web;
in {
  options.amaali7.develop.web = with types; {
    enable = mkBoolOpt false "Whether or not to enable web.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      html-tidy
      nodePackages.stylelint
      nodePackages.js-beautify
      nodePackages.javascript-typescript-langserver
    ];
  };
}
