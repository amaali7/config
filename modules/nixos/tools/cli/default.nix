{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.cli;
in {
  options.amaali7.tools.cli = with types; {
    enable = mkBoolOpt false "Whether or not to enable cli.";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        sqlite
        file
        fd
        starship
        scrot
        acpi
        (ripgrep.override { withPCRE2 = true; })
        shfmt
        shellcheck
        pywal
        macchina
        usbutils
        wget
        terminal-colors
        sysstat
        ntfs3g
        killall
        bat
        eza
        ranger
        socat
        jq
        freshfetch
        htop
        acpi
        inotify-tools
      ];
  };
}
