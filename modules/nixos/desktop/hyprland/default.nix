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
        hidpi = true;
        enable = true;
      };
    };
    programs.waybar = enabled;
    services.xserver.desktopManager.xfce = enabled;
    amaali7 = {
      # desktop.eww-hyprland = enabled;
      home = {
        extraOptions = {
          home.file = {
            ".local/bin/hypr" = {
              executable = true;
              text = ''
                #!${pkgs.bash}/bin/bash
                  export WLR_NO_HARDWARE_CURSORS=1
                  export _JAVA_AWT_WM_NONREPARENTING=1
                  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

                  if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
                    PATH="$HOME/.local/bin:$HOME/bin:$PATH"; fi

                  if ! [[ "$PATH" =~ "$HOME/.nix-profile/bin:" ]]; then
                    PATH="$HOME/.nix-profile/bin:$PATH"; fi

                  export PATH
                  # exec nixGL ${pkgs.hyprland}/bin/Hyprland
                  exec Hyprland
              '';
            };
          };
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
        # file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
        # file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
        # file.".config/hypr/autostart.conf".source = ./autostart.conf;
        # file.".config/hypr/binds.conf".source = ./binds.conf;
        # file.".config/hypr/settings.conf".source = ./settings.conf;
        # file.".config/hypr/theme.conf".source = ./theme.conf;
        # file.".config/hypr/rules.conf".source = ./rules.conf;
      };
    };
  };
}
