{ src, stdenv, fetchgit }:

stdenv.mkDerivation {
  pname = "sfmono-nf";
  version = "dev";
  src = fetchgit {
    url = "https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized";
    rev = "dc5a3e6fcc2e16ad476b7be3c3c17c2273b260ea";
    sha256 = "sha256-9zU1CmmF1zhuxIcEjbQMvWgEypOtRjyuKLx4FWBQIoI=";
    fetchSubmodules = true;
  };
  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src/*.otf $out/share/fonts
  '';

  meta.description = "Monaco font but patched with the nerd fonts tool!";
}
