{ lib, makeDesktopItem, appimageTools, stdenv, fetchurl }:

appimageTools.wrapType2 {
  name = "draw-io";
  version = "23.0.2";
  src = fetchurl {
    url = "https://github.com/jgraph/drawio-desktop/releases/download/v23.0.2/drawio-x86_64-23.0.2.AppImage";
    sha256 = "0gi4j5vcz5r9yrv75ad0wbqmxsdic3v1m1zzi4smzxx3vs7z5xzh";
  };

  # extraPkgs = [
  #   (makeDesktopItem {
  #     name = "drawio";
  #     exec = "drawio %U";
  #     icon = "drawio";
  #     desktopName = "drawio";
  #     comment = "draw.io desktop";
  #     mimeTypes = [ "application/vnd.jgraph.mxfile" "application/vnd.visio" ];
  #     categories = [ "Graphics" ];
  #     startupWMClass = "drawio";
  #   })
  # ];

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
