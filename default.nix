{ pkgs ? import <nixpkgs> { } }:

rec {
  llvmPackages = pkgs.recurseIntoAttrs (pkgs.callPackage ./pkgs/development/compilers/llvm/trunk {
    inherit (pkgs.stdenvAdapters) overrideCC;
    buildLlvmTools = pkgs.buildPackages.llvmPackages.tools;
    targetLlvmLibraries = pkgs.targetPackages.llvmPackages.libraries or llvmPackages.libraries;
    targetLlvm = pkgs.targetPackages.llvmPackages.llvm or llvmPackages.llvm;
  });

  clang = llvmPackages.clang;

  clang-tools = pkgs.callPackage ./pkgs/development/tools/clang-tools { inherit clang; };

  withCcache = {
    llvmPackages = llvmPackages.override {
      enableCcache = true;
      ccacheStdenv = pkgs.ccacheStdenv;
    };
  };
}
