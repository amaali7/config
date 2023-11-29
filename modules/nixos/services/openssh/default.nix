{ options, config, pkgs, lib, host ? "", format ? "", inputs ? { }, ... }:

with lib;
with lib.amaali7;
let
  cfg = config.amaali7.services.openssh;

  user = config.users.users.${config.amaali7.user.name};
  user-id = builtins.toString user.uid;

  # @TODO(jakehamilton): This is a hold-over from an earlier Snowfall Lib version which used
  # the specialArg `name` to provide the host name.
  name = host;

  default-key =
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCyiqfFYOd1Rqip/g9SfbmkI8Qbl43udMIu+43yJEOgYZ4VMcoJ6xx6d6KJdW7HVjnGGzs4xtpTniXZZ3jMhToxoQXgs9FyylV3fNuiibi1GcGg3yWT6PvU4DVznlP7OZoS8++V+vH9JNDAsZRXwgWrOnauE/L8V/UDJlvNZZA7FAN0GmDd50kiuD28+HDOwaxjJXFBjWhSpCXXTQ3l3IiTlslFYAkJaq0sStbRMHmYJM2aIFIBlHJkwxgSCslx8X00i2nCfgzRjJTBYn2HUuEaNHhOdyqHKBkcvxYZlT4Hw7N0nUlJ41kCdOBJkM/5PLCgFp5Z2DtFET3Eqo2gKUzOz9zFs8yqlB1le7Md9O4bX6cMKQTkSENirMxwkudu9CzdROGrjbXGR9V8QcMDoZVRMZD5SN8GHA0IcifnAcFha2Xzaqq0tCWuryA8CXlRskPHHy7hmpajpCwT+BOBZRnpllt2+9t53gIoyHfpSTgeJ9mZwQJ3pipc8t+NN3oQtEE= amaali1991@gmail.com";

  other-hosts = lib.filterAttrs
    (key: host:
      key != name && (host.config.amaali7.user.name or null) != null)
    ((inputs.self.nixosConfigurations or { }) // (inputs.self.darwinConfigurations or { }));

  other-hosts-config = lib.concatMapStringsSep
    "\n"
    (name:
      let
        remote = other-hosts.${name};
        remote-user-name = remote.config.amaali7.user.name;
        remote-user-id = builtins.toString remote.config.users.users.${remote-user-name}.uid;

        forward-gpg = optionalString (config.programs.gnupg.agent.enable && remote.config.programs.gnupg.agent.enable)
          ''
            RemoteForward /run/user/${remote-user-id}/gnupg/S.gpg-agent /run/user/${user-id}/gnupg/S.gpg-agent.extra
            RemoteForward /run/user/${remote-user-id}/gnupg/S.gpg-agent.ssh /run/user/${user-id}/gnupg/S.gpg-agent.ssh
          '';

      in
      ''
        Host ${name}
          User ${remote-user-name}
          ForwardAgent yes
          Port ${builtins.toString cfg.port}
          ${forward-gpg}
      ''
    )
    (builtins.attrNames other-hosts);
in
{
  options.amaali7.services.openssh = with types; {
    enable = mkBoolOpt false "Whether or not to configure OpenSSH support.";
    authorizedKeys =
      mkOpt (listOf str) [ default-key ] "The public keys to apply.";
    port = mkOpt port 2222 "The port to listen on (in addition to 22).";
    manage-other-hosts = mkOpt bool true "Whether or not to add other host configurations to SSH config.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;

      settings = {
        PermitRootLogin = if format == "install-iso" then "yes" else "no";
        PasswordAuthentication = false;
      };

      extraConfig = ''
        StreamLocalBindUnlink yes
      '';

      ports = [
        22
        cfg.port
      ];
    };

    programs.ssh.extraConfig = ''
      Host *
        HostKeyAlgorithms +ssh-rsa

      ${optionalString cfg.manage-other-hosts other-hosts-config}
    '';

    amaali7.user.extraOptions.openssh.authorizedKeys.keys =
      cfg.authorizedKeys;
  };
}
