{ options, config, lib, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.security;
in {
  options.amaali7.security = with types; {
    enable = mkBoolOpt false "Whether or not to enable zathura.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    security.polkit.enable = true;
    security = {
      # allow wayland lockers to unlock the screen
      pam.services.swaylock.text = "auth include login";

    };
  };
}
