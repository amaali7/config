{ lib, config, inputs, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.amaali7) enabled;

  cfg = config.amaali7.shell.zsh;
in
{
  options.amaali7.shell.zsh = {
    enable = mkEnableOption "enable zsh";
  };

  config = mkIf cfg.enable {
    amaali7 = {
      home = {
        extraOptions = {
          home = {
            sessionVariables = {
              SHELL = "${pkgs.zsh}/bin/zsh";
            };
          };
        };
      };
      user.extraOptions = {
        shell = pkgs.zsh;
      };
    };
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [ zsh ];
    programs.zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        ls = "lsd";
        gadd = "git add -A";
        gcom = "git commit -m $1";
      };
      histSize = 10000;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "sudo"
          "terraform"
          "systemadmin"
          "vi-mode"
        ];
      };
    };

  };
}
