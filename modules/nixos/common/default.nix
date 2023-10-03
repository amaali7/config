{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.common;
in {
  options.amaali7.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common.";
  };

  config = mkIf cfg.enable {
    environment.pathsToLink = [ "/libexec" "/share/nix-direnv" ];
    environment.variables.C_INCLUDE_PATH =
      "${pkgs.amaali7.libcrypt.dev}/include";
    environment.variables = {
      QT_QPA_PLATFORM_PLUGIN_PATH =
        "${pkgs.qt5.qtbase.bin.outPath}/lib/qt-${pkgs.qt5.qtbase.version}/plugins";
    };

    # nix options for derivations to persist garbage collection
    nix.settings = {
      keep-outputs = true;
      keep-derivations = true;
    };

    amaali7 = {
      tools = {
        archive = enabled;
        cli = enabled;
        direnv = enabled;
        fonts = enabled;
        gui = enabled;
        hardware = enabled;
        network = enabled;
        pentest = enabled;
        terminals.kitty = enabled;
        tui = enabled;
        vm = enabled;
        vnc = enabled;
        X11 = enabled;
      };
    };
  };
}
