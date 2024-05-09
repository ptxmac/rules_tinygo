load("@rules_tinygo//:def.bzl", "tinygo_toolchain")

filegroup(
    name = "tools",
    srcs = ["bin/tinygo"],
)

filegroup(
    name = "src",
    srcs = glob(["src/**/*"]),
)

filegroup(
    name = "lib",
    srcs = glob(["lib/**/*"]),
)

filegroup(
    name = "targets",
    srcs = glob(["targets/**/*"]),
)

tinygo_toolchain(
    name = "toolchain_impl",
    srcs = [":src"],
    libs = [":lib"],
    targets = [":targets"],
    tools = [":tools"],
)

toolchain(
    name = "toolchain_darwin_amd64",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":toolchain_impl",
    toolchain_type = "@rules_tinygo//:toolchain_type",
)

toolchain(
    name = "toolchain_darwin_arm64",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:arm64",
    ],
    target_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:arm64",
    ],
    toolchain = ":toolchain_impl",
    toolchain_type = "@rules_tinygo//:toolchain_type",
)

toolchain(
    name = "toolchain_linux_amd64",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":toolchain_impl",
    toolchain_type = "@rules_tinygo//:toolchain_type",
)
