{ stdenv
, lib
, fetchFromGitHub
, substituteAll
}:
stdenv.mkDerivation rec {
  name = "xmake";
  version = "f777cbc1781ce6af19d56decf63c4126dd6b01e8";

  src = fetchFromGitHub {
    owner = "xmake-io";
    repo = "xmake";
    rev = version;
    hash = "sha256-ScWc/WS34ph+j7y+6TK8ujul1h9GxpELc2+RBf5S8qA=";
    fetchSubmodules = true;
  };

  patches = [
    ./xrepo.patch
  ];

  postPatch = ''
    substituteInPlace scripts/xrepo.sh --replace "@out@" "$out"
  '';

  enableParallelBuilding = true;

  meta = {
    homepage = "https://xmake.io";
    description = "🔥 A cross-platform build utility based on Lua";
    license = lib.licenses.asl20;
  };
}
