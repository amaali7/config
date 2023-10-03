{ options, config, lib, pkgs, ... }:

with lib; with lib.amaali7;
let cfg = config.amaali7.develop.toolkit.emacs;
in {
  options.amaali7.develop.toolkit.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable emacs.";
  };

  config = mkIf cfg.enable {
    services.emacs = {
      package = pkgs.emacs29;
      enable = true;
      defaultEditor = true;
      install = true;
    };
    environment.systemPackages = with pkgs;
      [
        (nerdfonts.override {
          fonts = [ "FiraCode" "DroidSansMono" "CascadiaCode" ];
        })
        fzf
        sbcl
        (with pkgs;
          stdenv.mkDerivation {
            name = "irony-server-2016-08-24";
            src = fetchFromGitHub {
              owner = "Sarcasm";
              repo = "irony-mode";
              rev = "870d1576fb279bb93f776a71e65f45283c423a9e";
              sha256 = "0iv3nfa6xf9qbq9pzfa96jc3n2z5pp6lvj58w69ly2gn47jqgnxc";
            };
            buildInputs = [ cmake llvm llvmPackages.clang-unwrapped ];
            preConfigure = "cd server";
          })
      ] ++ (with pkgs;
        [
          ((emacsPackagesFor emacs29).emacsWithPackages
            (epkgs: [ epkgs.vterm ]))
        ]);
  };
}
