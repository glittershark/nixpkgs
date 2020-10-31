{ fetchurl, requireFile, ... }:

rec {
  version = "20.2.1";
  ce = {
    graalvm = {
      java8 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/graalvm-ce-java8-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };

      java11 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/graalvm-ce-java11-linux-amd64-${version}.tar.gz";
        sha256 = "e5d92d361e7859fe5f88c92d7bb466e285e07f1e4e2d9944948f85fa0e3aee2b";
      };
    };

    native-image = {
      java8 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/native-image-installable-svm-java8-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };

      java11 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/native-image-installable-svm-java11-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
    };

    llvm-toolchain = {
      java8 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/llvm-toolchain-installable-svm-java8-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };

      java11 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/llvm-toolchain-installable-svm-java11-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
    };

    ruby = {
      java8 = fetchurl {
        url = "https://github.com/graalvm/truffleruby/releases/download/vm-${version}/ruby-installable-svm-java8-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };

      java11 = fetchurl {
        url = "https://github.com/graalvm/truffleruby/releases/download/vm-${version}/ruby-installable-svm-java11-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
    };

    python = {
      java8 = fetchurl {
        url = "https://github.com/graalvm/graalpython/releases/download/vm-${version}/python-installable-svm-java8-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };

      java11 = fetchurl {
        url = "https://github.com/graalvm/graalpython/releases/download/vm-${version}/python-installable-svm-java11-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
    };

    wasm = {
      java8 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/wasm-installable-svm-java8-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };

      java11 = fetchurl {
        url = "https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${version}/wasm-installable-svm-java11-linux-amd64-${version}.tar.gz";
        sha256 = "0000000000000000000000000000000000000000000000000000";
      };
    };
  };
  ee = {
    graalvm = {
      java8 = requireFile {
        name = "graalvm-ee-java8-linux-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "e0bb182146283a43824dd2c2ceeb89b6ff7a93f9a85da889f8663ce1c2bd3002";
      };
      java11 = requireFile {
        name = "graalvm-ee-java11-linux-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "e5d92d361e7859fe5f88c92d7bb466e285e07f1e4e2d9944948f85fa0e3aee2b";
      };
    };

    native-image = {
      java8 = requireFile {
        name = "native-image-installable-svm-svmee-java8-linux-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "37ac6a62f68adad513057a60513ba75749adf98cc73999b3918afe159900428d";
      };
      java11 = requireFile {
        name = "native-image-installable-svm-svmee-java11-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "f62df715ad529f8b84854644ac99e0a9a349232c7f03985d20a2a8be20edaa44";
      };
    };

    llvm-toolchain = {
      java8 = requireFile {
        name = "llvm-toolchain-installable-svm-svmee-java8-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "da98a8c17b0c724b41d1596b57e282a1ecfcbf9140404dfb04b0d4d9fb159d8a";
      };
      java11 = requireFile {
        name = "llvm-toolchain-installable-svm-svmee-java11-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "fc442c396e92f59d034a69175104cb3565c3d128426bd939cc94c6ceccbb720f";
      };
    };

    ruby = {
      java8 = requireFile {
        name = "ruby-installable-svm-svmee-java8-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "44f6887249f2eb54cba98dd4d9de019da5463d92982e03bf655fffe4bb520daf";
      };
      java11 = requireFile {
        name = "ruby-installable-svm-svmee-java11-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "941f3752ccb097958f49250586f04c305092ded3ea4c1b7d9a0f7632e47fa335";
      };
    };

    python = {
      java8 = requireFile {
        name = "python-installable-svm-svmee-java8-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "5c3993c701bd09c6064dcf4a6d9c7489620d0654b03c74682398c788c0211c09";
      };
      java11 = requireFile {
        name = "python-installable-svm-svmee-java11-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "de3ebf35ce47dc399d7976cbd09fde0e85f2c10f85bc3fe8f32bb9e2b500ab70";
      };
    };

    wasm = {
      java8 = requireFile {
        name = "wasm-installable-svm-svmee-java8-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "c0a334b271fd32c098bb3c42eada7eafb9f536becaa756097eebe4682915b067";
      };
      java11 = requireFile {
        name = "wasm-installable-svm-svmee-java11-amd64-${version}.tar.gz";
        url  = "https://www.oracle.com/technetwork/graalvm/downloads/index.html";
        sha256 = "9e801071992a0ff976bc40b640a8b9368fd8ea890ba986543658fcbaa3a7fd68";
      };
    };
  };
}
