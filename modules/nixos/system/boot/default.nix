{ options, config, pkgs, lib, ... }:

with lib;
with lib.amaali7;
let cfg = config.amaali7.system.boot;
in
{
  options.amaali7.system.boot = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting.";
  };

  config = mkIf cfg.enable {
    # Bootloader.
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
      useOSProber = true;
    };
    boot.plymouth = { enable = true; };
    # for build raspberry pi image 
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
