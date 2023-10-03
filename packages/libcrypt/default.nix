{ fetchurl, lib, stdenv, gettext, npth, libgpg-error, buildPackages, libassuan
, ... }:
stdenv.mkDerivation rec {
  pname = "libgcrypt";
  version = "1.10.1";

  src = fetchurl {
    url = "https://gnupg.org/ftp/gcrypt/${pname}/${pname}-${version}.tar.bz2";
    sha256 = "1pp9zyx02bzgzjzldxf0mx9kp3530xgaaqcz4n2cv100ddaaw57g";
  };

  outputs = [ "out" "dev" "info" ];
  outputBin = "dev"; # libassuan-config

  depsBuildBuild = [ buildPackages.stdenv.cc ];
  buildInputs = [ npth gettext libassuan ];

  configureFlags = [ "--with-libgpg-error-prefix=${libgpg-error.dev}" ];

  doCheck = true;

  # Make sure includes are fixed for callers who don't use libassuan-config
  # postInstall = ''
  #   sed -i 's,#include <gpg-error.h>,#include "${libgpg-error.dev}/include/gpg-error.h",g' $dev/include/assuan.h
  # '';

  meta = with lib; {
    description = "IPC library used by GnuPG and related software";
    longDescription = ''
      Libassuan is a small library implementing the so-called Assuan
      protocol.  This protocol is used for IPC between most newer
      GnuPG components.  Both, server and client side functions are
      provided.
    '';
    homepage = "http://gnupg.org";
    license = licenses.lgpl2Plus;
    # platforms = ["x86_64-linux"];
    maintainers = [ maintainers.erictapen ];
  };
}
