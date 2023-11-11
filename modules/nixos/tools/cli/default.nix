{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.cli;
in {
  options.amaali7.tools.cli = with types; {
    enable = mkBoolOpt false "Whether or not to enable cli.";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ls = "lsd";
        update-system =
          "cd ~/work/Nix/config/ && doas nixos-rebuild switch --flake .#laptop";
      };
    };
    users.defaultUserShell = pkgs.fish;
    environment.shells = with pkgs; [ fish ];
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
        exa
        ranger
        socat
        jq
        htop
        acpi
        inotify-tools
      ];
  };
}
