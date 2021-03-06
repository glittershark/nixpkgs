{ lib, stdenv
, fetchFromGitHub
, fetchpatch
, cmake
, pkg-config
, boost17x
, openssl
, zlib
, libsodium
, olm
, spdlog
, nlohmann_json
}:

stdenv.mkDerivation rec {
  pname = "mtxclient";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "Nheko-Reborn";
    repo = "mtxclient";
    rev = "v${version}";
    sha256 = "1x820rcfz5r203dc8a0rzavcjjx10fsv1dicqg65m6kxx1w95j5r";
  };

  cmakeFlags = [
    # Network requiring tests can't be disabled individually:
    # https://github.com/Nheko-Reborn/mtxclient/issues/22
    "-DBUILD_LIB_TESTS=OFF"
    "-DBUILD_LIB_EXAMPLES=OFF"
    "-Dnlohmann_json_DIR=${nlohmann_json}/lib/cmake/nlohmann_json"
    # Can be removed once either https://github.com/NixOS/nixpkgs/pull/85254 or
    # https://github.com/NixOS/nixpkgs/pull/73940 are merged
    "-DBoost_NO_BOOST_CMAKE=TRUE"
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    spdlog
    boost17x
    openssl
    zlib
    libsodium
    olm
  ];

  meta = with lib; {
    description = "Client API library for Matrix, built on top of Boost.Asio";
    homepage = "https://github.com/Nheko-Reborn/mtxclient";
    license = licenses.mit;
    maintainers = with maintainers; [ fpletz ];
    platforms = platforms.all;
    # Should be fixable if a higher clang version is used, see:
    # https://github.com/NixOS/nixpkgs/pull/85922#issuecomment-619287177
    broken = stdenv.targetPlatform.isDarwin;
  };
}
