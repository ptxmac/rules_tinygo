load("@rules_tinygo//:def.bzl", "binaryen_toolchain")

filegroup(
    name = "tools",
    srcs = glob(["bin/*"]),
)

binaryen_toolchain(
    name = "toolchain_impl",
    tools = [":tools"],
)

toolchain(
    name = "binaryen_darwin_arm64",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:arm64",
    ],
    target_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:arm64",
    ],
    toolchain = ":toolchain_impl",
    toolchain_type = "@rules_tinygo//:binaryen_type",
)

toolchain(
    name = "binaryen_linux_amd64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":toolchain_impl",
    toolchain_type = "@rules_tinygo//:binaryen_type",
)
