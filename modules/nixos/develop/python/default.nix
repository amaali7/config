{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.develop.python;
in {
  options.amaali7.develop.python = with types; {
    enable = mkBoolOpt false "Whether or not to enable python.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python311
      python311Packages.setuptools
      python311Packages.poetry-core
      python311Packages.pip
      python311Packages.nose
      python311Packages.black
      python311Packages.pyflakes
      pipenv
      python311Packages.pytest
      pyenv
      poetry
    ];
  };
}
