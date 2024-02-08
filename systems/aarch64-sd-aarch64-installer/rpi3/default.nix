{ pkgs, config, lib, modulesPath, inputs, ... }:

with lib;
with lib.amaali7;
{
  imports = [
    (modulesPath + "/installer/sd-card/sd-image.nix")
  ];
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-uuid/dbe6da9d-f411-4d35-b1f7-db3c635712f1";
    fsType = "btrfs";
    options = [ "subvol=root" ];
  };
  
  fileSystems."/nix" = lib.mkDefault  {
    device = "/dev/disk/by-uuid/dbe6da9d-f411-4d35-b1f7-db3c635712f1";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };
  
  fileSystems."/home" = lib.mkDefault  {
    device = "/dev/disk/by-uuid/dbe6da9d-f411-4d35-b1f7-db3c635712f1";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  sdImage = {
    compressImage = false;
  };
  
  amaali7 = {
    archtypes.rpi = enabled;
  };   

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
