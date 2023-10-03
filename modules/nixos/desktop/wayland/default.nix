{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.desktop.wayland;
in {
  options.amaali7.desktop.wayland = with types; {
    enable = mkBoolOpt false "Whether or not to enable wayland.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wlsunset
      wayfire
      wl-clipboard
      wl-gammactl
      wl-clipboard
      wf-recorder
      watershot
      swww
      wlprop
    ];
    qt.platformTheme = "qt5ct";
    # QT
    hardware.opengl = {
      driSupport32Bit = true;
      enable = true;
    };
  };
}
