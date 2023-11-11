{ lib, config, pkgs, host ? null, format ? "unknown", ... }:

let
  inherit (lib) types;
  inherit (lib.amaali7) mkOpt;
in
{
  options.amaali7.host = {
    name = mkOpt (types.nullOr types.str) host "The host name.";
  };
}
