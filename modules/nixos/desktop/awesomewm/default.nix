{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let
  cfg = config.amaali7.desktop.awesomewm;
in
{
  options.amaali7.desktop.awesomewm = with types; {
    enable = mkBoolOpt false "Whether or not to enable Awesome Window Manager.";
  };

  config = mkIf cfg.enable {
    services.acpid = enabled;
    services.xserver = {
      enable = true;
      displayManager = {
        defaultSession = "none+awesome";
      };
      windowManager.awesome = {
        enable = true;
        package = pkgs.awesome-git;
        # luaModules = with pkgs.luaPackages; [
        # luarocks # is the package manager for Lua modules
        # luadbi-mysql # Database abstraction layer
        # ];
      };
    };
    amaali7 = {
      desktop = {
        common-tiling = enabled;
        themes = enabled;
        xfce = enabled;
      };
      # system.fonts = enabled;
      home = {
        extraOptions = {
          home.packages = with pkgs; [
            foot
            rofi
            imagemagick
            sassc
            picom-allusive
            wezterm
            material-icons
            material-symbols
          ];
        };
      };
    };

  };
}
