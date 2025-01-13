{
  rustPlatform,
  fetchFromGitHub,
  lib,
}:

rustPlatform.buildRustPackage rec {
  pname = "display3d";
  version = "0.1.17";
  
  src = fetchFromGitHub {
    owner = "renpenguin";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-CqbYFz78hjEhqzHoziWDvBPMmhAjx2Sqx56PSM81Pd4="; # richtiger hash prop
  };

  cargoHash = lib.fakeHash;

  doInstallCheck = true;

  meta = with lib; {
    description = "CLI for rendering and animating 3D objects";
    mainProgram = "display3D";
    homepage = "https://github.com/renpenguin/display3d";
    license = licenses.mit;
    maintainers = [ quentin ];
  }; 
}