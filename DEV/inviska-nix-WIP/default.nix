{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "11.0";
  pname = "Inviska";

  src = fetchurl {
    url = "https://www.videohelp.com/download/${pname}_MKV_Extract-${version}-x86_64.AppImage";
    hash = "sha256-nv+ouKyS1Gd9tf1j7Cz5F+AFmqTu5Ql543yqVylDC/I=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  meta = {
    description = "Audio extract from mkv containers";
    homepage = "https://www.videohelp.com/software/Inviska-MKV-Extract";
    downloadPage = "https://www.videohelp.com/software/Inviska-MKV-Extract";
    license = lib.licenses.gpl2Only;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ quentin ];
    platforms = [ "x86_64-linux" ];
  };
}
