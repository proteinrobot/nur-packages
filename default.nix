{ pkgs ? import <nixpkgs> { } }:

let
  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs');

  env = rec {
    gccForLibs = pkgs.gcc13.cc;

    gccStdenv = pkgs.gcc13Stdenv;

    stdenv = llvm.llvmPackages.stdenv;

    ccacheStdenv = pkgs.ccacheStdenv.override { stdenv = gccStdenv; };

    mkShell = pkgs.mkShell.override { inherit stdenv; };

    wrapCCWith = { ... }@args:
      pkgs.wrapCCWith (args // { inherit gccForLibs; });
  };

  llvm = rec {
    llvmPackages = pkgs.recurseIntoAttrs
      (callPackage ./pkgs/development/compilers/llvm/trunk {
        stdenv = env.gccStdenv;
        inherit (env) ccacheStdenv;
        inherit (pkgs.stdenvAdapters) overrideCC;
        buildLlvmTools = llvmPackages.tools;
        targetLlvmLibraries = llvmPackages.libraries;
        targetLlvm = llvmPackages.llvm;
      });

    libcxxStdenv = llvmPackages.llvmPackages;

    clang = llvmPackages.clang;

    clang-tools = callPackage ./pkgs/development/tools/clang-tools { };
  };

  build = {
    xmake = callPackage ./pkgs/development/tools/build-managers/xmake { };

    ld-is-cxx-hook = pkgs.makeSetupHook { name = "ld-is-cxx-hook"; }
      ./pkgs/build-support/setup-hooks/ld-is-cxx-hook.sh;
  };

  libraries = {
    boost-ut = callPackage ./pkgs/development/libraries/boost-ext/boost-ut { };

    fmt = callPackage ./pkgs/development/libraries/fmt { };

    taskflow = callPackage ./pkgs/development/libraries/taskflow { };
  };

  pkgs' = env // llvm // build // libraries;
in pkgs'
