{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.X11;
in {
  options.amaali7.tools.X11 = with types; {
    enable = mkBoolOpt false "Whether or not to enable x11.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        sxhkd
        # picom-ibhagwan
        arandr
        numlockx
        xbindkeys
        xorg.xdpyinfo
        xorg.xbacklight
        xorg.xmodmap
        libxkbcommon
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXi
        xorg.libX11
        light
      ];
  };
}
