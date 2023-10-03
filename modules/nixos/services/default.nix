{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.services;
in {
  options.amaali7.services = with types; {
    enable = mkBoolOpt false "Whether or not to enable zathura.";
  };

  config = mkIf cfg.enable {
    systemd.services.ModemManager.enable = true;
    services.postgresql.enable = true;
    services.teamviewer.enable = true;
    services.xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
      displayManager = {
        autoLogin = {
          enable = true;
          user = "ai3wm";
        };
        gdm = { enable = true; };
      };
    };
    services.gvfs.enable = true;
    services.acpid.enable = true;
    services.printing.enable = true;
    services.openssh.enable = true;
    services.geoclue2.appConfig = {
      "com.github.app" = {
        isAllowed = true;
        isSystem = false;
        users = [ "1000" ];
      };
    };
  };
}
