{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.desktop.common-tiling;
in {
  options.amaali7.desktop.common-tiling = with types; {
    enable = mkBoolOpt false "Whether or not to enable common-tiling.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        # picom
        pulseaudio
        bat
        exa
        light
        playerctl
        maim
        jq
        mpd
        ncmpcpp
        rofi
        # redshift
        brightnessctl
        upower
        inotify-tools
        acpid
        wmctrl
        # xdotool
        # xclip
        scrot
        alsa-utils
        acpi
        # mpdris2
        dunst
        # nitrogen
        # Rust Base
        zellij
        yazi
        helix
        lsd
      ];
  };
}
