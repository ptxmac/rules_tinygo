workspace(
    name = "rules_tinygo",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Golang
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "80a98277ad1311dacd837f9b16db62887702e9f1d1c4c9f796d0121a46c8e184",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.46.0/rules_go-v0.46.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.46.0/rules_go-v0.46.0.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_download_sdk", "go_register_toolchains", "go_rules_dependencies")

go_download_sdk(
    name = "go_sdk_1_21_7",
    goarch = "arm64",
    goos = "darwin",
    version = "1.21.7",
)

go_rules_dependencies()

go_register_toolchains()

## tinygo testing
load("@rules_tinygo//:deps.bzl", "tinygo_download")

tinygo_download(
    name = "tinygo_darwin_x86_64",
    sha256 = "6767934acc2d0a1b29b110de098dcf056b8cca1ce2737f01bc137c5d1f4f1ad7",
    urls = ["https://github.com/tinygo-org/tinygo/releases/download/v0.30.0/tinygo0.30.0.darwin-amd64.tar.gz"],
)

register_toolchains(
    "@tinygo_darwin_x86_64//:toolchain",
)
