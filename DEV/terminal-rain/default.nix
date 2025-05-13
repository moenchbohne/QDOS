{ pkgs ? import <nixpkgs> {} }:

let
  pythonEnv = pkgs.python3.withPackages (ps: [
    # Add Python dependencies here if needed
    ps.unicurses
  ]);
in

pkgs.stdenv.mkDerivation rec {
  pname = "terminal-rain-lightning";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "rmaake1";
    repo = pname;
    rev = "b7199c634d6d38cfd546700b63acd6e746fc565c";  # Replace with actual commit hash
    sha256 = "0plw88jnhgkplapfgaq7ly63zc36h5nr9ygs9wagckhz5b3f0193";    # Replace with prefetched hash
  };

  nativeBuildInputs = [ pythonEnv pkgs.makeWrapper ];

  installPhase = ''
    # Create installation directories
    mkdir -p $out/libexec/$pname
    mkdir -p $out/bin

    # Copy Python files
    cp -r *.py $out/libexec/$pname/

    # Create executable wrapper
    makeWrapper ${pythonEnv}/bin/python3 $out/bin/terminal-rain-lightning \
      --add-flags "$out/libexec/$pname/terminal_rain_lightning.py" \
      --set PYTHONPATH "$PYTHONPATH:$out/libexec/$pname"
  '';

  meta = with pkgs.lib; {
    description = "Matrix-like terminal rain animation with lightning effects";
    homepage = "https://github.com/rmaake1/terminal-rain-lightning";
    license = licenses.mit;
    maintainers = [ quentin ];
  };
}