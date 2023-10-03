{ pkgs, lib, ... }:

with lib;
with lib.amaali7; {
  imports = [ ./hardware.nix ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.plymouth = { enable = true; };
  boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };
  boot.kernelModules = [ "kvm-intel" ];

  time.timeZone = "Africa/Cairo";

  amaali7 = {
    nix = enabled;
    common = enabled;
    vm.waydroid = enabled;
    security = enabled;
    services = enabled;
    games = enabled;
    desktop = {
      common-tiling = enabled;
      themes = enabled;
      xfce = enabled;
    };
    develop.surrealdb = enabled;
    groups = {
      common = enabled;
      develop = enabled;
    };
    media = {
      gimp = enabled;
      mousai = enabled;
      obs-studio = enabled;
      vlc = enabled;
    };
    office = {
      obsidian = enabled;
      zathura = enabled;
      libreoffice = enabled;
    };
    web = enabled;
  };

  system.stateVersion = "23.05";
}
