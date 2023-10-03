{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.lua;
in {
  options.amaali7.develop.lua = with types; {
    enable = mkBoolOpt false "Whether or not to enable lua.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lua
      lua54Packages.cjson
      lua54Packages.luarocks
    ];
  };
}
