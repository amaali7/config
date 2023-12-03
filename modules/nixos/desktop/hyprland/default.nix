{ options, inputs, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.desktop.hyprland;
in {
  options.amaali7.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Whether or not to enable i3.";
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland = {
        # hidpi = true;
        enable = true;
      };
    };
    programs.waybar = enabled;

    amaali7 = {
      desktop = {
        common-tiling = enabled;
        themes = enabled;
        wayland = enabled;
        xfce = enabled;
      };
      home = {
        extraOptions = {
          home.packages = with pkgs; [
            foot
            wofi
            swaybg
            wlsunset
            wl-clipboard
            wl-gammactl
            wl-clipboard
            wf-recorder
            hyprpicker
            imagemagick
            hyprpaper
            slurp
            sassc
            watershot
            swww
            hyprland
            hyprland-protocols
            hyprland-share-picker
            xdg-desktop-portal-hyprland
            wlprop
            inputs.hyprland-contrib.packages.${pkgs.system}.hyprprop
          ];
        };
      };
    };
  };
}
