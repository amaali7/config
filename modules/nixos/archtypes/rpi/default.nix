{ options, config, lib, pkgs, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.archtypes.rpi;
in
{
  options.amaali7.archtypes.rpi = with types; {
    enable =
      mkBoolOpt false "Whether or not to enable the rpi archetype.";
  };

  config = mkIf cfg.enable {
  boot = {
    # kernelPackages = pkgs.linuxKernel.packages.linux_rpi3;
    kernelParams = ["cma=320M"];
    initrd = {
      availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
      kernelModules = [ "vc4" "bcm2835_dma"  ];

    };
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
    services.xserver = {
      enable = true;
      displayManager = {
        lightdm = enabled;
      };
    };
    networking.wireless = disabled;
    amaali7 = {
      nix =enabled;
      shell.zsh =enabled;
      hardware.networking = enabled; 
      cli-apps = {
        neovim = enabled;
        zellij = enabled;
      };
      tools.git = enabled;
      user = {
          name = "pi";
          initialPassword = "pi";
        };
    };
  };
}
