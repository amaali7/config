{

  description = "Amaali7";
  inputs = {
    # NixPkgs (nixos-23.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # NixPkgs Unstable (nixos-unstable)
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager (release-22.05)
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # macOS Support (master)
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Generate System Images
    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Lib
    snowfall-lib.url = "github:snowfallorg/lib?ref=v2.1.1";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # Snowfall Flake
    flake.url = "github:snowfallorg/flake?ref=v1.1.0";
    flake.inputs.nixpkgs.follows = "unstable";

    # Snowfall Thaw
    thaw.url = "github:snowfallorg/thaw?ref=v1.0.4";

    # Comma
    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "unstable";

    # System Deployment
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "unstable";

    # Run unpatched dynamically compiled binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "unstable";

    # Neovim
    neovim.url = "github:jakehamilton/neovim";
    neovim.inputs.nixpkgs.follows = "unstable";

    # Tmux
    tmux.url = "github:jakehamilton/tmux";
    tmux.inputs = {
      nixpkgs.follows = "nixpkgs";
      unstable.follows = "unstable";
    };

    # Discord Replugged
    replugged.url = "github:LunNova/replugged-nix-flake";
    replugged.inputs.nixpkgs.follows = "unstable";

    # Discord Replugged plugins / themes
    discord-tweaks = {
      url = "github:NurMarvin/discord-tweaks";
      flake = false;
    };
    discord-nord-theme = {
      url = "github:DapperCore/NordCord";
      flake = false;
    };


    # GPG default configuration
    gpg-base-conf = {
      url = "github:drduh/config";
      flake = false;
    };

    bibata-cursors = {
      url = "github:suchipi/Bibata_Cursor";
      flake = false;
    };

    snowfall-docs = {
      url = "github:snowfallorg/docs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = { url = "github:nix-community/nur"; };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-f2k = {
      url = "github:fortuneteller2k/nixpkgs-f2k";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          namespace = "amaali7";
          meta = {
            name = "amaali7";
            title = "Amaali7";
          };
        };
      };
    in
    lib.mkFlake {
      nixConfig = {
        extra-substituters = [
          "https://cache.nixos.org?priority=10"
          "https://fortuneteller2k.cachix.org"

        ];
        extra-trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        ];
      };

      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          #   # @FIXME(jakehamilton): This is a workaround for 22.11 and can
          #   # be removed once NixPkgs is upgraded to 23.05.
          #   # "electron-20.3.11"
          #   # "nodejs-16.20.0"
          #   # "python-2.7.18.6"
          #   "electron-24.8.6"
          #   # "electron-22.3.27"
          "electron-25.9.0"
        ];
      };
      overlays = with inputs; [
        neovim.overlays.default
        flake.overlays.default
        snowfall-docs.overlay
        nixgl.overlay
        nixpkgs-f2k.overlays.default
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nur.nixosModules.nur
        nix-ld.nixosModules.nix-ld
        # @TODO(jakehamilton): Replace amaali7.services.attic now that vault-agent
        # exists and can force override environment files.
        # attic.nixosModules.atticd
      ];
      systems.hosts.laptop.modules = with inputs;
        [ nixos-hardware.nixosModules.dell-latitude-7390 ];
      #
      deploy = lib.mkDeploy { inherit (inputs) self; };

      checks = builtins.mapAttrs
        (system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy)
        inputs.deploy-rs.lib;
    };
}
