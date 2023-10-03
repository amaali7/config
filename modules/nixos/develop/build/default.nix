{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.build;
in {
  options.amaali7.develop.build = with types; {
    enable = mkBoolOpt false "Whether or not to enable build.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        cmake
        gnumake
        ninja
        meson
        pkg-config
      ];
  };
}
