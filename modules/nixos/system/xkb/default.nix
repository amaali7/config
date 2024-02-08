{ options, config, lib, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.system.xkb;
in
{
  options.amaali7.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "us";
      xkbOptions = "caps:escape";
    };
  };
}
