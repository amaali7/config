{ pkgs, lib, inputs, ... }:

with lib;
with lib.amaali7; {
  imports = [ ./hardware.nix ];
  boot.kernelModules = [ "kvm-intel" ];
  nixpkgs.buildPlatform.system = "x86_64-linux";
  nixpkgs.hostPlatform.system = "aarch64-linux";
  environment.systemPackages =
    [ inputs.home-manager.packages.${pkgs.system}.home-manager ];
  amaali7 = {
    archetypes = {
      workstation = enabled;
      gaming = enabled;
    };

    #   hardware.audio = {
    #     alsa-monitor.rules = [
    #       (mkAlsaRename {
    #         name = "alsa_card.usb-Generic_Blue_Microphones_2240BAH095W8-00";
    #         description = "Blue Yeti";
    #       })
    #       (mkAlsaRename {
    #         name = "alsa_output.usb-Generic_Blue_Microphones_2240BAH095W8-00.analog-stereo";
    #         description = "Blue Yeti";
    #       })
    #       (mkAlsaRename {
    #         name = "alsa_input.usb-Generic_Blue_Microphones_2240BAH095W8-00.analog-stereo";
    #         description = "Blue Yeti";
    #       })
    #     ];
    #   };
  };
  system.stateVersion = "23.11";
}
