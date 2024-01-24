{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.amaali7; let
  cfg = config.amaali7.suites.development;
  apps = {
    docker = enabled;
    #drawio = enabled;
    neovide = enabled;
    #obsidian = enabled;
    # surrealdb = enabled;
  };
  cli-apps = {
    zellij = enabled;
    neovim = enabled;
  };
in
{
  options.amaali7.suites.development = with types; {
    enable =
      mkBoolOpt false
        "Whether or not to enable common development configuration.";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [
      12345
      3000
      3001
      8080
      8081
    ];

    amaali7 = {
      inherit apps cli-apps;

      develop = {
        assembly = enabled;
        binary = enabled;
        build = enabled;
        c_cpp = enabled;
        c_cpp_libs = enabled;
        embdedded = enabled;
        javascript = enabled;
        lisp = enabled;
        lua = enabled;
        python = enabled;
        rust = enabled;
        web = enabled;
      };

      tools = {
        # attic = enabled;
        # at = enabled;
        direnv = enabled;
        # go = enabled;
        http = enabled;
        # k8s = enabled;
        # node = enabled;
        # titan = enabled;
        qmk = enabled;
      };

      virtualisation = { podman = enabled; };
    };
  };
}
