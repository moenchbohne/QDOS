{ 
  lib
, buildPythonPackage
, fetchPypi

# build-system
, setuptools-scm

 }:

buildPythonPackage rec {
  pname = "BeatPrints ";
  version = "1.1.4";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-z4Q23FnYaVNG/NOrKW3kZCXsqwDWQJbOvnn7Ueyy65M=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  doCheck = false;

  meta = with lib; {
    changelog = "https://github.com/pytest-dev/pytest/releases/tag/${version}";
    description = "Framework for writing tests";
    homepage = "https://github.com/pytest-dev/pytest";
    license = licenses.mit;
    maintainers = with maintainers; [ domenkozar lovek323 madjar lsix ];
  };
}