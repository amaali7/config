{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.misc;
in
{
  options.amaali7.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    amaali7.home.configFile."wgetrc".text = "";

    environment.systemPackages = with pkgs; [
      chezmoi
      procs
      htop
      pipes-rs
      gtypist
      ttyper
      fzf
      killall
      unzip
      file
      jq
      clac
      wget
    ];
  };
}
