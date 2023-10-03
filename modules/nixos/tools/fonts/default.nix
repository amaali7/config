{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.fonts;
in {
  options.amaali7.tools.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to enable fonts.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        fira-code
        ubuntu_font_family
        line-awesome
        font-awesome
        font-awesome_4
        font-awesome_5
        victor-mono
        material-icons
        fontconfig
        source-code-pro
        terminus_font
        terminus_font_ttf
      ];
  };
}
