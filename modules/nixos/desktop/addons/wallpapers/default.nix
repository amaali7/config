{ options, config, pkgs, lib, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.desktop.addons.wallpapers;
  inherit (pkgs.amaali7) wallpapers;
in
{
  options.amaali7.desktop.addons.wallpapers = with types; {
    enable = mkBoolOpt false
      "Whether or not to add wallpapers to ~/Pictures/wallpapers.";
  };

  config = {
    amaali7.home.file = lib.foldl
      (acc: name:
        let wallpaper = wallpapers.${name};
        in
        acc // {
          "Pictures/wallpapers/${wallpaper.fileName}".source = wallpaper;
        })
      { }
      (wallpapers.names);
  };
}
