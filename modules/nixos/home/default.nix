{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.home;
in {
  imports = with inputs; [ home-manager.nixosModules.home-manager ];

  options.amaali7.home = with types; {
    file = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>home.file</option>.";
    configFile = mkOpt attrs { }
      "A set of files to be managed by home-manager's <option>xdg.configFile</option>.";
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    amaali7.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.amaali7.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.amaali7.home.configFile;
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      users.${config.amaali7.user.name} =
        mkAliasDefinitions options.amaali7.home.extraOptions;
    };
  };
}
