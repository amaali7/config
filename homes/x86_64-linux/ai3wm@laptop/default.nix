{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.amaali7;
{
  amaali7 = {
    user = {
      enable = true;
      name = "ai3wm";
    };
    cli-apps = {
      home-manager = enabled;
    };
  };
}
