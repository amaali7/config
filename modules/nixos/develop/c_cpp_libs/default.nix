{ options, config, lib, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.c_cpp_libs;
in {
  options.amaali7.develop.c_cpp_libs = with types; {
    enable = mkBoolOpt false "Whether or not to enable c_cpp libs.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        ncurses6
        ncurses
        gnutls
        libcrypt
        taglib
        libstdcxx5
        libclang
      ];
  };
}
