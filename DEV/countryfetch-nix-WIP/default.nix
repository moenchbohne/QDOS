{
  rustPlatform,
  fetchFromGitHub,
  lib,
}:

rustPlatform.buildRustPackage rec {
  pname = "countryfetch";
  version = "0.1.9";
  
  src = fetchFromGitHub {
    owner = "nik-rev";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-KdFgY54vXLmq6IZfJzZ1IeZ2eQuNJoCRZUV3rVuPpcY=";
  };

  cargoHash = lib.fakeHash;

  doInstallCheck = true;
  useFetchCargoVendor = true;

  meta = with lib; {
    description = "A Command-line tool similar to Neofetch for obtaining information about your country";
    mainProgram = "countryfetch";
    homepage = "https://github.com/nik-rev/countryfetch";
    license = licenses.mit;
    maintainers = [ quentin ];
  }; 
}