{
  lib,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  pkg-config,
}:

rustPlatform.buildRustPackage rec {
  pname = "thundery";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "loefey";
    repo = "thundery";
    rev = version;
    hash = "sha256-8VM9o2OqbYlT1kNQXygGQp8O4QPugy+GcmkQhWwUAu0=";
    fetchSubmodules = true;
  };

  BuildInputs = [
    openssl
    pkg-config
  ];

  useFetchCargoVendor = true;
  cargoHash = "sha256-wqtv77aAJTRUSs5ZjqMouuzeDW2O7wg0JsLgoKnpJ5U=";

  meta = with lib; {
    description = "Thundery is a command-line application that fetches and displays weather information from the OpenWeatherMap API";
    homepage = "https://github.com/loefey/thundery";
    license = licenses.gpl3;
    mainProgram = "thundery";
    maintainers = with maintainers; [ quentin ];
  };
}