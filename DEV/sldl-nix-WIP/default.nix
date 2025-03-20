{ stdenv, lib
, fetchurl
, alsa-lib
, openssl
, zlib
, pulseaudio
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "slsk-batchdl";
  version = "2.4.3";
  arch = "x64";

  src = fetchurl {
    url = "https://github.com/fiso64/slsk-batchdl/releases/download/v${version}/sldl_linux-${arch}.zip";
    hash = "sha256-FE+VmHZDGV9G2RjJW/p7u/4jNuo+6QqXue35DvBy9yc=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    alsa-lib
    openssl
    zlib
    pulseaudio
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D studio-link-standalone-v${version} $out/bin/studio-link
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/fiso64/slsk-batchdl";
    description = "An automatic downloader for Soulseek built with Soulseek.NET. Accepts CSV files as well as Spotify and YouTube urls.";
    platforms = platforms.linux;
  };
}