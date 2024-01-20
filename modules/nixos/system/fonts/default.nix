{ options, config, pkgs, lib, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.system.fonts;
in
{
  options.amaali7.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [ font-manager ];
    fonts = {
      packages = with pkgs; [
        # icon fonts
        material-symbols
        # normal fonts
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

        jost
        lexend
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        roboto

        # nerdfonts
        (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      ] ++ cfg.fonts;

      # use fonts specified by user rather than default ones
      enableDefaultPackages = false;

      # user defined fonts
      # the reason there's Noto Color Emoji everywhere is to override DejaVu's
      # B&W emojis that would sometimes show instead of some Color emojis
      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

  };
}
