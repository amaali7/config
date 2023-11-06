{ pkgs, lib, inputs, ... }:

with lib;
with lib.amaali7; {
  imports = [ ./hardware.nix ];
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
  boot.kernelModules = [ "kvm-intel" ];

  time.timeZone = "Africa/Cairo";

  environment.systemPackages = [ inputs.home-manager.packages.${pkgs.system}.home-manager ];
  amaali7 = {
    develop.embdedded = enabled;
    nix = enabled;
    common = enabled;
    # vm.waydroid = enabled;
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
