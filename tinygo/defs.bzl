"Public API re-exports"

# load("//binaryen:toolchain.bzl", _binaryen_toolchain = "binaryen_toolchain")
load("//tinygo/private:rules.bzl", _tinygo_binary = "tinygo_binary")

tinygo_binary = _tinygo_binary

# binaryen_toolchain = _binaryen_toolchain
