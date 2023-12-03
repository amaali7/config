{ pkgs, config, lib, modulesPath, inputs, ... }:

with lib;
with lib.amaali7;
{
  # imports = with inputs.nixos-hardware.nixosModules; [
  #   (modulesPath + "/installer/scan/not-detected.nix")
  # ];
  imports = [
    (modulesPath + "/profiles/base.nix")
    (modulesPath + "/profiles/installation-device.nix")
    (modulesPath + "/installer/cd-dvd/sd-image.nix")
  ];

  boot.loader.grub.enable = false;
  boot.loader.raspberryPi.enable = true;
  boot.loader.raspberryPi.version = 4;
  boot.kernelPackages = pkgs.linuxPackages_rpi4;

  boot.consoleLogLevel = lib.mkDefault 7;

  sdImage = {
    firmwareSize = 128;
    # This is a hack to avoid replicating config.txt from boot.loader.raspberryPi
    populateFirmwareCommands =
      "${config.system.build.installBootLoader} ${config.system.build.toplevel} -d ./firmware";
    # As the boot process is done entirely in the firmware partition.
    populateRootCommands = "";
  };

  # the installation media is also the installation target,
  # so we don't want to provide the installation configuration.nix.
  installer.cloneConfig = false;

  amaali7 = {
    archetypes = {
      server = enabled;
    };

    system = {


      boot = {
        # Raspberry Pi requires a specific bootloader.
        enable = mkForce false;
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
