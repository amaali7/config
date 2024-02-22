{ inputs, lib, config, pkgs, ... }:
with lib; with lib.amaali7;
let cfg = config.amaali7.cli-apps.neovim;
in {
  options.amaali7.cli-apps.neovim = with types; {
    enable = mkBoolOpt false "Whether or not to enable neovim.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.nixvim.packages.${pkgs.system}.default
      #neovim
      nil
      stylua
      lua-language-server
      deno
      nixpkgs-fmt
    ];
  };
}
