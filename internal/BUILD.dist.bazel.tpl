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
    name = "toolchain",
    toolchain = ":toolchain_impl",
    toolchain_type = "@rules_tinygo//:toolchain_type",
)
