{ options, lib, config, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.develop.toolkit.neovide;
in {
  options.amaali7.develop.toolkit.neovide = with types; {
    enable = mkBoolOpt false "Whether or not to enable eww-hyprland.";
  };

  config = mkIf cfg.enable {
    # theres no programs.eww.enable here because eww looks for files in .config
    # thats why we have all the home.files
    # eww package
    environment.systemPackages = with pkgs; [
      neovide
      neovim
      nil
      stylua
      lua-language-server
      deno
      nixpkgs-fmt
    ];
  };
}
