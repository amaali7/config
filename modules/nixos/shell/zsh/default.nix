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
      };
      histSize = 10000;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "thefuck"
          "sudo"
          "terraform"
          "systemadmin"
          "vi-mode"
        ];
      };
    };

  };
}
