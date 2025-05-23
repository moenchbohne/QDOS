{ stdenv, lib, fetchurl, dpkg }:

stdenv.mkDerivation rec {
  pname = "eshare-client";
  version = "7.5.0930";

  src = fetchurl {
    url = "https://cdn.sharemax.cn/rel/linux/EShareClient_v${version}_amd64.deb";
    sha256 = "tgwi4mw5cf6vK/5n9D5EepKZ5v9HS4WIS2BzKBR9ZRc=";
  };

  dontBuild = true;
  nativeBuildInputs = [
    dpkg
    ];

  unpackPhase = ''
   dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ${pname} $out/bin/${pname}
    chmod +x $out/bin/${pname}
  '';

  meta = with lib; {
    description = "Screensharing";
    homepage = "https://eshare.app/";
    license = licenses.bsd3;
    platforms = platforms.unix;
  };
}
