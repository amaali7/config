{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.groups.develop;
in {
  options.amaali7.groups.develop = with types; {
    enable = mkBoolOpt false "Whether or not to enable groups develop.";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      tools.direnv = enabled;
      develop = {
        binary = enabled;
        build = enabled;
        c_cpp = enabled;
        c_cpp_libs = enabled;
        javascript = enabled;
        python = enabled;
        rust = enabled;
        lua = enabled;
        toolkit = {
          common = enabled;
          docker = enabled;
          emacs = enabled;
          git = enabled;
          neovide =enabled;
        };
        web = {
          enable = true;
          altair = enabled;
        };
      };
    };
  };
}
