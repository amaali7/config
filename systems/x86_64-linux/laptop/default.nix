{ pkgs, lib, inputs, ... }:

with lib;
with lib.amaali7; {
  imports = [ ./hardware.nix ];
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
    useOSProber = true;
  };
  boot.loader.grub.users = {
    root = {
      hashedPassword = "grub.pbkdf2.sha512.10000.A1BCF32710C6D9E553CC9D5C528E822BBB6D3CA91F08B9312B23111D7BBE275FDB7B20035389B2CF3895B3F1DA91B675251F655C03923CD48AF527D32B8A36BE.BBC15665DBCD6CB049B793546C523A094BE889FFEABDEAD642E924D49545CCDE5ED4448B2E5321D3CD21452570FE1FEBDB60A75DDF862B58E602D6BDED21343C";
    };
  };
  environment.etc."crypttab".text = ''
    root /dev/disk/by-uuid/9e56ed11-d281-4439-9b9d-a99eba30c275 /etc/secrets/initrd/keyfile0.bin
    nix-stor /dev/disk/by-uuid/17b41ea9-1038-479b-bdbc-147ed1940efe /etc/secrets/initrd/keyfile0.bin
  '';
  boot.plymouth = { enable = true; };
  boot.kernelModules = [ "kvm-intel" ];

  time.timeZone = "Africa/Cairo";

  environment.systemPackages = [ inputs.home-manager.packages.${pkgs.system}.home-manager ];
  amaali7 = {
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
