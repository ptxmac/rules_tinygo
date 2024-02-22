load(
    "//internal:rules.bzl",
    _tinygo_binary = "tinygo_binary",
)
load(
    "//internal:toolchain.bzl",
    _tinygo_toolchain = "tinygo_toolchain",
)

tinygo_binary = _tinygo_binary

tinygo_toolchain = _tinygo_toolchain
