{ stdenv, lib, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "boost-ut";
  version = "e53a47d37bc594e80bd5f1b8dc1ade8dce4429d3";

  src = fetchFromGitHub {
    owner = "boost-ext";
    repo = "ut";
    rev = version;
    hash = "sha256-QrD+srp+0yb3Qmqpncg+rrBg9kstyNnUwEtTVTRq8X8=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DBOOST_UT_ALLOW_CPM_USE=OFF"
    "-DBOOST_UT_BUILD_EXAMPLES=OFF"
    "-DBOOST_UT_BUILD_TESTS=OFF"
    "-DINCLUDE_INSTALL_DIR=include"
    "-DPROJECT_DISABLE_VERSION_SUFFIX=ON"
  ];

  enableParallelBuilding = true;

  meta = {
    homepage = "https://github.com/boost-ext/ut";
    description = "UT: C++20 μ(micro)/Unit Testing Framework ";
    license = lib.licenses.boost;
  };
}

