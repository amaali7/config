{ options, config, lib, pkgs, ... }:
with lib;
with lib.amaali7;
let cfg = config.amaali7.tools.network;
in {
  options.amaali7.tools.network = with types; {
    enable = mkBoolOpt false "Whether or not to enable network.";
  };

  config = mkIf cfg.enable {
    networking = {
      #      hostId = "dtt61";
      networkmanager.enableFccUnlock = true;
      domain = "coffeeshop.com";
      dhcpcd.enable = false;
      networkmanager.enable = true;
      usePredictableInterfaceNames = false;
      #interfaces.enp0s31f6.ipv4.addresses = [{
      #  address = "192.168.1.2";
      #  prefixLength = 28;
      #}];
      vlans = {
        vlan100 = {
          id = 100;
          interface = "eth0";
        };
        vlan101 = {
          id = 101;
          interface = "eth0";
        };
      };
      interfaces.vlan100.ipv4.addresses = [{
        address = "10.101.111.2";
        prefixLength = 24;
      }];
      interfaces.vlan101.ipv4.addresses = [{
        address = "10.101.19.3";
        prefixLength = 24;
      }];
      defaultGateway = "192.168.1.1";
      nameservers = [ "1.1.1.1" "8.8.8.8" ];
    };
    environment.systemPackages = with pkgs;
      with pkgs.amaali7; [
        modemmanager
        networkmanagerapplet
        mobile-broadband-provider-info
        usb-modeswitch
        macchanger
        iw
        dnsmasq
      ];
  };
}
