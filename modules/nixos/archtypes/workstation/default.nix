{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.archetypes.workstation;
in
{
  options.amaali7.archetypes.workstation = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the workstation archetype.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lolcat
      colorls
      # propagatedIcon
    ];
    amaali7 = {
      suites = {
        common = enabled;
        desktop = enabled;
        development = enabled;
        art = enabled;
        video = enabled;
        social = enabled;
        media = enabled;
      };
      services = enabled;

      tools = {
        appimage-run = enabled;
      };

      home = {
        file = {
          "Desktop/.keep".text = "";
          "Documents/.keep".text = "";
          "Downloads/.keep".text = "";
          "Music/.keep".text = "";
          "Pictures/.keep".text = "";
          #"Videos/.keep".text = "";
          "work/.keep".text = "";
          # ".face".source = cfg.icon;
          #   "Pictures/${
          #   amaali7.user.icon.fileName or (builtins.baseNameOf amaali7.user.icon)
          # }".source = amaali7.user.icon;
        };
        extraOptions = {
          targets.genericLinux.enable = true;
          home = {
            sessionVariables = {
              QT_XCB_GL_INTEGRATION = "none"; # kde-connect
              EDITOR = "nvim";
              VISUAL = "neovide";
              # BROWSER = "flatpak run org.mozilla.firefox";
              TERMINAL = "wezterm";
              XCURSOR_THEME = "Qogir";
              NIXPKGS_ALLOW_UNFREE = "1";
              SHELL = "${pkgs.fish}/bin/fish";
            };
            sessionPath = [ "$HOME/.local/bin" "$HOME/.cargo/bin/" "$HOME/.npm-packages/bin/" ];
          };
          xdg.desktopEntries = {
            "org.wezfurlong.wezterm" = {
              name = "WezTerm";
              comment = "Wez's Terminal Emulator";
              icon = "org.wezfurlong.wezterm";
              exec = "nixGL ${pkgs.wezterm}/bin/wezterm start --cwd .";
              categories = [ "System" "TerminalEmulator" "Utility" ];
              terminal = false;
            };
            "neovide" = {
              categories = [ "Utility" "TextEditor" "Development" "IDE" ];
              comment = "Code Editing. Redefined.";
              exec = "/usr/bin/env -u WAYLAND_DISPLAY neovide %F";
              genericName = "Text Editor";
              icon = "neovide";
              mimeType = [ "text/plain" "inode/directory" ];
              name = "NeoVide";
              startupNotify = true;
              type = "Application";
            };
          };
          programs.home-manager = enabled;
          programs.git = {
            enable = true;
            userName = "Abdallah Ali";
            userEmail = "amaali1991@gmail.com";
            aliases = { st = "status"; };
          };
          home.shellAliases = {
            lc = "${pkgs.colorls}/bin/colorls --sd";
            lcg = "lc --gs";
            lcl = "lc -1";
            lclg = "lc -1 --gs";
            lcu = "${pkgs.colorls}/bin/colorls -U";
            lclu = "${pkgs.colorls}/bin/colorls -U -1";
            vim = "nvim";
            vi = "nvim";
          };
          # User config
          programs = {
            starship = {
              enable = true;
              settings = {
                character = {
                  success_symbol = "[➜](bold green)";
                  error_symbol = "[✗](bold red) ";
                  vicmd_symbol = "[](bold blue) ";
                };
              };
            };

          };
        };
      };
    };
  };
}
