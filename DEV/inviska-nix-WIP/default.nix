{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "1.4.0";
  pname = "quba";

  src = fetchurl {
    url = "https://www.videohelp.com/download/Inviska_MKV_Extract-11.0-x86_64.AppImage";
    hash = "sha256-EsTF7W1np5qbQQh3pdqsFe32olvGK3AowGWjqHPEfoM=";
  };

  appimageContents = appimageTools.extractType1 { inherit name src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${meta.mainProgram}'
  '';

  meta = {
    description = "Viewer for electronic invoices";
    homepage = "https://www.videohelp.com/software/Inviska-MKV-Extract";
    downloadPage = "https://www.videohelp.com/software/Inviska-MKV-Extract";
    license = lib.licenses.gpl2Only;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ quentin ];
    platforms = [ "x86_64-linux" ];
  };
}
