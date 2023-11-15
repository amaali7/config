{ options, config, pkgs, lib, ... }:

with lib; with lib.amaali7;
let
  cfg = config.amaali7.user;
  defaultIconFileName = "profile.png";
  defaultIcon = pkgs.stdenvNoCC.mkDerivation {
    name = "default-icon";
    src = ./. + "/${defaultIconFileName}";

    dontUnpack = true;

    installPhase = ''
      cp $src $out
    '';

    passthru = { fileName = defaultIconFileName; };
  };
  propagatedIcon = pkgs.runCommandNoCC "propagated-icon"
    {
      passthru = { fileName = cfg.icon.fileName; };
    } ''
    local target="$out/share/amaali7-icons/user/${cfg.name}"
    mkdir -p "$target"

    cp ${cfg.icon} "$target/${cfg.icon.fileName}"
  '';
in
{
  options.amaali7.user = with types; {
    name = mkOpt str "ai3wm" "The name to use for the user account.";
    fullName = mkOpt str "Abdallah Adam" "The full name of the user.";
    email = mkOpt str "amaali1991@gmail.com" "The email of the user.";
    initialPassword = mkOpt str "password"
      "The initial password to use when the user is first created.";
    icon = mkOpt (nullOr package) defaultIcon
      "The profile picture to use for the user.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { }
      "Extra options passed to <option>users.users.<name></option>.";
  };

  config = {
    programs.fish.enable = true;
    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      shell = pkgs.fish;

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      # uid = 1000;

      extraGroups = [ "wheel" "dialout" "network" ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
