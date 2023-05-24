{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "fmt";
  version = "6fe895410d96cd60a61a9a15387d4e9c94a8d819";

  src = fetchFromGitHub {
    owner = "fmtlib";
    repo = "fmt";
    rev = version;
    sha256 = "sha256-uWbnf/iZnLhO22lm+SLM0qR8EE99ih8xvK0HXMrfC/k=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [ "-DFMT_SYSTEM_HEADERS=ON" "-DBUILD_SHARED_LIBS=ON" ];

  enableParallelBuilding = true;

  meta = {
    homepage = "https://fmt.dev";
    description = "A modern formatting library";
    license = lib.licenses.mit;
  };
}
