{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.desktop.common;
in {
  options.amaali7.desktop.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common.";
  };

  config = mkIf cfg.enable {
    fonts = {
      fonts = with pkgs; [
        # icon fonts
        material-symbols

        # normal fonts
        jost
        lexend
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        roboto

        # nerdfonts
        (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      ];

      # use fonts specified by user rather than default ones
      enableDefaultFonts = false;

      # user defined fonts
      # the reason there's Noto Color Emoji everywhere is to override DejaVu's
      # B&W emojis that would sometimes show instead of some Color emojis
      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    # use Wayland where possible (electron)
    environment.variables.NIXOS_OZONE_WL = "1";

    hardware = {
      # smooth backlight control
      brillo.enable = true;

      opengl = {
        extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
        extraPackages32 = with pkgs.pkgsi686Linux; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };

      opentabletdriver.enable = true;

      xpadneo.enable = true;
    };

    # enable location service
    location.provider = "geoclue2";

    programs = {
      # make HM-managed GTK stuff work
      dconf.enable = true;

      seahorse.enable = true;
    };

    services = {
      # provide location
      geoclue2.enable = true;

      gnome.gnome-keyring.enable = true;

      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        jack.enable = true;
        pulse.enable = true;
      };
      power-profiles-daemon.enable = true;

      # profile-sync-daemon
      psd = {
        enable = true;
        resyncTimer = "10m";
      };

      # battery info & stuff
      upower.enable = true;

      # needed for GNOME services outside of GNOME Desktop
      dbus.packages = [ pkgs.gcr ];

      udev = {
        packages = with pkgs; [ gnome.gnome-settings-daemon ];
        extraRules = ''
          # add my android device to adbusers
          SUBSYSTEM=="usb", ATTR{idVendor}=="22d9", MODE="0666", GROUP="adbusers"
        '';
      };
    };
    security = {
      # allow wayland lockers to unlock the screen
      pam.services.swaylock.text = "auth include login";

      # userland niceness
      rtkit.enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        xfce.ristretto
        lxappearance
        xarchiver
        gvfs
        dex
        redshift
        networkmanagerapplet
      ];
  };
}
