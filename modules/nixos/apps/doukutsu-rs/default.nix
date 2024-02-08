{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.apps.doukutsu-rs;
  desktopItem = pkgs.makeDesktopItem {
    name = "doukutsu-rs";
    desktopName = "doukutsu-rs";
    genericName =
      "A fully playable re-implementation of Cave Story (Doukutsu Monogatari) engine written in Rust.";
    exec = "${pkgs.amaali7.doukutsu-rs}/bin/doukutsu-rs";
    icon = ./icon.png;
    type = "Application";
    categories = [ "Game" "AdventureGame" ];
    terminal = false;
  };
in
{
  options.amaali7.apps.doukutsu-rs = with types; {
    enable = mkBoolOpt false "Whether or not to enable doukutsu-rs.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.amaali7; [
      doukutsu-rs
      desktopItem
    ];
  };
}
