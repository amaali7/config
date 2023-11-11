{ options, config, pkgs, lib, ... }:

with lib; with lib.amaali7;
let
  cfg = config.amaali7.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = { fileName = defaultIconFileName; };
  };
  propagatedIcon = pkgs.runCommandNoCC "propagated-icon"
    {
      passthru = { fileName = cfg.icon.fileName; };
    } ''
    local target="$out/share/amaali7-icons/user/${cfg.name}"
    mkdir -p "$target"

    cp ${cfg.icon} "$target/${cfg.icon.fileName}"
  '';
in
{
  options.amaali7.user = with types; {
    name = mkOpt str "ai3wm" "The name to use for the user account.";
    fullName = mkOpt str "Abdallah Adam" "The full name of the user.";
    email = mkOpt str "amaali1991@gmail.com" "The email of the user.";
    initialPassword = mkOpt str "password"
      "The initial password to use when the user is first created.";
    icon = mkOpt (nullOr package) defaultIcon
      "The profile picture to use for the user.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { }
      "Extra options passed to <option>users.users.<name></option>.";
  };

  config = {
    environment.systemPackages = with pkgs; [ lolcat colorls propagatedIcon ];

    amaali7 = {
      desktop = {
        hyprland = enabled;
        common-tiling = enabled;
      };
    };

    amaali7.home = {
      file = {
        "Desktop/.keep".text = "";
        "Documents/.keep".text = "";
        "Downloads/.keep".text = "";
        "Music/.keep".text = "";
        "Pictures/.keep".text = "";
        #"Videos/.keep".text = "";
        "work/.keep".text = "";
        ".face".source = cfg.icon;
        "Pictures/${
          cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        }".source = cfg.icon;
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

    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      shell = pkgs.fish;

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      # uid = 1000;

      extraGroups = [ "wheel" "dialout" "network" ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
