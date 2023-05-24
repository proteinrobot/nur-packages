{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "taskflow";
  version = "3.6.0";

  src = fetchFromGitHub {
    owner = "taskflow";
    repo = "taskflow";
    rev = "v${version}";
    hash = "sha256-Iy9BhkyJa2nFxwVXb4LAlgVAHnu+58Ago2eEgAIlZ7M=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [ "-DTF_BUILD_TESTS=OFF" "-DTF_BUILD_PROFILER=ON" ];

  enableParallelBuilding = true;

  meta = {
    homepage = "https://taskflow.github.io";
    description =
      "A General-purpose Parallel and Heterogeneous Task Programming System";
    license = lib.licenses.mit;
  };
}
