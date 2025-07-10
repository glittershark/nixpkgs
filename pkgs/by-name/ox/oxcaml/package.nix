{ stdenv, clangStdenv, lib, autoconf, fetchFromGitLab, fetchFromGitHub, fetchurl
, fetchpatch, libtool, ocaml-ng, pkg-config, rsync, which
, variant ? "pi-r5-md-sc", }:

let
  version = "5.2.0minus-15";

  extraConfigureFlags = {
    pi = "--enable-poll-insertion";
    r5 = "--enable-runtime5";
    fp = "--enable-frame-pointers";
    asan = "--enable-address-sanitizer";
    md = "--enable-multidomain";
    sc = "--enable-stack-checks";
  };

  features =
    if variant == "normal" then [ ] else lib.strings.splitString "-" variant;

  configureFlags = [ "--cache-file=/dev/null" ]
    ++ (builtins.map (f: extraConfigureFlags.${f}) features);

  myStdenv = if builtins.elem "asan" features then clangStdenv else stdenv;

  ocamlPackages = ocaml-ng.ocamlPackages_4_14;

  ocaml = (ocamlPackages.ocaml.override { stdenv = myStdenv; }).overrideAttrs ({
    configurePlatforms = [ ];
  });

  dune_3 = ocamlPackages.dune_3.overrideAttrs (new: old: {
    version = "3.15.2";
    src = fetchurl {
      url =
        "https://github.com/ocaml/dune/releases/download/${new.version}/dune-${new.version}.tbz";
      sha256 = "sha256-+VmYBULKhZCbPz+Om+ZcK4o3XzpOO9g8etegfy4HeTM=";
    };
  });
  menhirLib = ocamlPackages.menhirLib.overrideAttrs (new: old: rec {
    version = "20231231";
    src = fetchFromGitLab {
      domain = "gitlab.inria.fr";
      owner = "fpottier";
      repo = "menhir";
      rev = version;
      sha256 = "sha256-veB0ORHp6jdRwCyDDAfc7a7ov8sOeHUmiELdOFf/QYk=";
    };
  });
  menhir =
    let menhirSdk = ocamlPackages.menhirSdk.override { inherit menhirLib; };
    in (ocamlPackages.menhir.override { inherit menhirLib; }).overrideAttrs
    (new: old: {
      buildInputs = [ menhirLib menhirSdk ];
      postInstall = ''
        ln -s ${menhirLib}/lib/ocaml/*/site-lib/menhirLib $out/lib/
      '';
    });

in myStdenv.mkDerivation {
  pname = "oxcaml";
  inherit configureFlags;

  src = fetchFromGitHub {
    owner = "oxcaml";
    repo = "oxcaml";
    rev = version;
    hash = "sha256-MofIQbdhvUUhXxJHA8GrPYI6vbYMJtXR79yGHwx5k7c=";
  };

  version =
    "${version}${lib.concatMapStrings (feature: "-${feature}") features}";
  enableParallelBuilding = true;
  nativeBuildInputs = [ autoconf libtool menhir ocaml pkg-config rsync which ];

  preConfigure = ''
    CC="${myStdenv.cc.meta.mainProgram}"
    if [[ $CC == gcc ]]; then
        AS=as
    else
        AS="$CC -c"
    fi
    export AS CC
    mkdir -p .local/bin
    ln -s ${dune_3}/bin/dune .local/bin/dune
    configureFlags+=" --with-dune=$PWD/.local/bin/dune"
    autoconf
  '';

  postInstall = ''
    $out/bin/generate_cached_generic_functions.exe $out/lib/ocaml/cached-generic-functions
  '';

  passthru = { inherit configureFlags; };
}
