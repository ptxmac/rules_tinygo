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

go_rules_dependencies()

go_register_toolchains(
    version = "1.22.2",
)

## tinygo testing
load("@rules_tinygo//:deps.bzl", "binaryen_download", "tinygo_download")

TINYGO_VERSION = "0.31.2"

BINARYEN_VERSION = "117"

tinygo_download(
    name = "tinygo_darwin_amd64",
    sha256 = "73c185beceefdb627b7349dd945757f3b30f9e4cee0f085e36a8f965c94e9dda",
    urls = ["https://github.com/tinygo-org/tinygo/releases/download/v{0}/tinygo{0}.darwin-amd64.tar.gz".format(TINYGO_VERSION)],
)

tinygo_download(
    name = "tinygo_darwin_arm64",
    sha256 = "5b9ff15881bd23eb44ccd0e6c917db11e65c5532d654fc7198e6f6289aa0449d",
    urls = ["https://github.com/tinygo-org/tinygo/releases/download/v{0}/tinygo{0}.darwin-arm64.tar.gz".format(TINYGO_VERSION)],
)

tinygo_download(
    name = "tinygo_linux_amd64",
    sha256 = "48a83ae9efe619124d2ecac8aba0b039ea8dabf07765b1df26692b63cfd8fab8",
    urls = ["https://github.com/tinygo-org/tinygo/releases/download/v{0}/tinygo{0}.linux-amd64.tar.gz".format(TINYGO_VERSION)],
)

binaryen_download(
    name = "binaryen_darwin_arm64",
    prefix = "binaryen-version_{0}".format(BINARYEN_VERSION),
    sha256 = "f2d962ff294b38ea3cfbbae8f6c728089d9375a57bac9a1880eb86779d6d3a84",
    urls = ["https://github.com/WebAssembly/binaryen/releases/download/version_{0}/binaryen-version_{0}-arm64-macos.tar.gz".format(BINARYEN_VERSION)],
)

binaryen_download(
    name = "binaryen_linux_amd64",
    prefix = "binaryen-version_{0}".format(BINARYEN_VERSION),
    sha256 = "3dc677006555b355ea2da5e82602065a161d5e83eaefd3f759afa00b96e83212",
    urls = ["https://github.com/WebAssembly/binaryen/releases/download/version_{0}/binaryen-version_{0}-x86_64-linux.tar.gz".format(BINARYEN_VERSION)],
)

register_toolchains(
    "@tinygo_darwin_amd64//:toolchain_darwin_amd64",
    "@tinygo_darwin_arm64//:toolchain_darwin_arm64",
    "@tinygo_linux_amd64//:toolchain_linux_amd64",
    "@binaryen_darwin_arm64//:binaryen_darwin_arm64",
    "@binaryen_linux_amd64//:binaryen_linux_amd64",
)

# Stardoc
http_archive(
    name = "io_bazel_stardoc",
    sha256 = "62bd2e60216b7a6fec3ac79341aa201e0956477e7c8f6ccc286f279ad1d96432",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/stardoc/releases/download/0.6.2/stardoc-0.6.2.tar.gz",
        "https://github.com/bazelbuild/stardoc/releases/download/0.6.2/stardoc-0.6.2.tar.gz",
    ],
)

load("@io_bazel_stardoc//:setup.bzl", "stardoc_repositories")

stardoc_repositories()

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("@io_bazel_stardoc//:deps.bzl", "stardoc_external_deps")

stardoc_external_deps()

load("@stardoc_maven//:defs.bzl", stardoc_pinned_maven_install = "pinned_maven_install")

stardoc_pinned_maven_install()
