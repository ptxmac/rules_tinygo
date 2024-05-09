"""
# Tinygo rules for Bazel

> [!caution]
> EXPERIMENTAL

This package provides rules for building Go code with
 [TinyGo](https://tinygo.org/).

## Dependencies

Make sure [rules_go](https://github.com/bazelbuild/rules_go) is configured in your project.

## Setup

In `WORKSPACE`:

Start by loading the rules:

```bazel
git_repository(
    name = "rules_tinygo",
    commit = "0677286b5a5ceeb077044019152f5e72b23c37c9",
    remote = "https://github.com/ptxmac/rules_tinygo.git",
)
```

To use the TinyGo rules, both the tinygo and binaryen tools must be downloaded for the host architecture.


```bazel
TINYGO_VERSION = "0.31.2"
BINARYEN_VERSION = "117"

tinygo_download(
    name = "tinygo_darwin_arm64",
    sha256 = "5b9ff15881bd23eb44ccd0e6c917db11e65c5532d654fc7198e6f6289aa0449d",
    urls = ["https://github.com/tinygo-org/tinygo/releases/download/v{0}/tinygo{0}.darwin-arm64.tar.gz".format(TINYGO_VERSION)],
)

binaryen_download(
    name = "binaryen_darwin_arm64",
    prefix = "binaryen-version_{0}".format(BINARYEN_VERSION),
    sha256 = "f2d962ff294b38ea3cfbbae8f6c728089d9375a57bac9a1880eb86779d6d3a84",
    urls = ["https://github.com/WebAssembly/binaryen/releases/download/version_{0}/binaryen-version_{0}-arm64-macos.tar.gz".format(BINARYEN_VERSION)],
)
```

Then all toolchains must be registered:

```bazel
register_toolchains(
    "@tinygo_darwin_arm64//:toolchain_darwin_arm64",
    "@binaryen_darwin_arm64//:binaryen_darwin_arm64",
)
```

## Usage

load("@rules_tinygo//:def.bzl", "tinygo_binary")

tinygo_binary(
    name = "hello_wasi",
    srcs = ["hello.go"],
    out = "hello.wasi",
    target = "wasi",
)

# Rules
"""

load("//binaryen:repo.bzl", _binaryen_download = "binaryen_download")
load("//tinygo:repo.bzl", _tinygo_download = "tinygo_download")
load("//tinygo:rules.bzl", _tinygo_binary = "tinygo_binary")

tinygo_binary = _tinygo_binary
tinygo_download = _tinygo_download
binaryen_download = _binaryen_download
