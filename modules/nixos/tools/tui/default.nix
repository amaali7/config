{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.tui;
in {
  options.amaali7.tools.tui = with types; {
    enable = mkBoolOpt false "Whether or not to enable tui.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        chezmoi
        procs
        htop
        tmux
        pipes-rs
        gtypist
        ttyper
      ];
  };
}
