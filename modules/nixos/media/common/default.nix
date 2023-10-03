{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.media.common;
in {
  options.amaali7.media.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        # ocenaudio
        ffmpeg
        python311Packages.yt-dlp
        cmus
        taglib
        python311Packages.pytaglib
        imagemagick
      ];
  };
}
