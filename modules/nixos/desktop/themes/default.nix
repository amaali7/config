{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.desktop.themes;
in {
  options.amaali7.desktop.themes = with types; {
    enable = mkBoolOpt false "Whether or not to enable themes.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      home = {
        extraOptions = {
          home.packages = with pkgs; [
            # fonts
            (nerdfonts.override {
              fonts = [
                "FiraCode"
                "JetBrainsMono"
                "Ubuntu"
                "UbuntuMono"
                "CascadiaCode"
                "FantasqueSansMono"
                "FiraCode"
                "VictorMono"
                "Mononoki"
              ];
            })
            font-awesome

            # themes
            qogir-theme # gtk
            papirus-icon-theme
            qogir-icon-theme
            whitesur-icon-theme
            colloid-icon-theme
            adw-gtk3
          ];

          home = {
            pointerCursor = {
              package = pkgs.qogir-icon-theme;
              name = "Qogir";
              size = 24;
              gtk.enable = true;
            };
            # file = {
            #   ".config/gtk-4.0/gtk.css" = {
            #     text = ''
            #       window.messagedialog .response-area > button,
            #       window.dialog.message .dialog-action-area > button,
            #         .background.csd{ border-radius: 0; }
            #     '';
            #   };
            # };
          };

          # gtk = {
          #   enable = true;
          #   font.name = "Ubuntu Nerd Font";
          #   cursorTheme = {
          #     name = "Qogir";
          #     package = pkgs.qogir-icon-theme;
          #   };
          #   gtk3 = {
          #     bookmarks = [
          #       "file:///home/${config.amaali7.user.name}/Documents"
          #       "file:///home/${config.amaali7.user.name}/Music"
          #       "file:///home/${config.amaali7.user.name}/Pictures"
          #       "file:///home/${config.amaali7.user.name}/Videos"
          #       "file:///home/${config.amaali7.user.name}/Downloads"
          #     ];
          #     extraCss = ''
          #       headerbar, .titlebar,
          #       .csd:not(.popup):not(tooltip):not(messagedialog) decoration{ border-radius: 0; }
          #     '';
          #   };
          # };
        };
      };
    };
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        arc-theme
        arc-icon-theme
      ];
  };
}
