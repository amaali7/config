{ lib, fetchurl, appimageTools, makeWrapper, stdenv, ... }:
let
  pname = "drawio";
  version = "23.0.2";
  src = fetchurl {
    url = "https://github.com/jgraph/drawio-desktop/releases/download/v23.0.2/drawio-x86_64-23.0.2.AppImage";
    sha256 = "0gi4j5vcz5r9yrv75ad0wbqmxsdic3v1m1zzi4smzxx3vs7z5xzh";
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 rec {
  # or wrapType1
  inherit pname version src;
  extraInstallCommands = ''
    mv $out/bin/${pname}-${version} $out/bin/${pname}

    source "${makeWrapper}/nix-support/setup-hook"
    wrapProgram $out/bin/${pname} \
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"

    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = with lib; {
    description = "A desktop application for creating diagrams";
    homepage = "https://about.draw.io/";
    license = licenses.asl20;
    changelog = "https://github.com/jgraph/drawio-desktop/releases/tag/v${version}";
    maintainers = with maintainers; [ qyliss darkonion0 ];
    platforms = platforms.darwin ++ platforms.linux;
    broken = stdenv.isDarwin;
  };

}
