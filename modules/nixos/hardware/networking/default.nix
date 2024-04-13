{ options, config, pkgs, lib, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.hardware.networking;
in {
  options.amaali7.hardware.networking = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking support";
    hosts = mkOpt attrs { }
      (mdDoc "An attribute set to merge with `networking.hosts`");
  };

  config = mkIf cfg.enable {
    amaali7.user.extraGroups = [ "networkmanager" ];

    networking = {
      hosts = {
        "127.0.0.1" = [ "local.test" ] ++ (cfg.hosts."127.0.0.1" or [ ]);
      } // cfg.hosts;

      networkmanager = {
        enable = true;
        dhcp = "internal";
      };
    };
    environment.systemPackages = with pkgs; [
      inetutils
      iw
      dnsmasq
      networkmanagerapplet
    ];
    # Fixes an issue that normally causes nixos-rebuild to fail.
    # https://github.com/NixOS/nixpkgs/issues/180175
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
