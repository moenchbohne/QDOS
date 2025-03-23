{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "11.0";
  pname = "Inviska";

  src = fetchurl {
    url = "https://www.videohelp.com/download/Inviska_MKV_Extract-11.0-x86_64.AppImage?r=HRwDfTLT";
    hash = "sha256-ozw1GDHnPYKkxrWFZdSqsMib4CTFoxcKiIVDLzCR5NA=";
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
