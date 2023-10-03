{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.c_cpp;
in {
  options.amaali7.develop.c_cpp = with types; {
    enable = mkBoolOpt false "Whether or not to enable c_cpp.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        gcc-arm-embedded
        gdb
        openocd
        gcc
        clang-tools
        clang
        libclang
        ccls
        libcrypt
      ];
  };
}
