{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.apps.obs-studio;
in {
  options.amaali7.apps.obs-studio = with types; {
    enable = mkBoolOpt false "Whether or not to enable obs_studio.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        obs-studio
        obs-studio-plugins.obs-pipewire-audio-capture
        obs-studio-plugins.obs-gstreamer
      ];
  };
}
