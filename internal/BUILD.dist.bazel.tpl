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

tinygo_toolchain(
    name = "toolchain_impl",
    srcs = [":src"],
    libs = [":lib"],
    tools = [":tools"],
)

toolchain(
    name = "toolchain",
    toolchain = ":toolchain_impl",
    toolchain_type = "@rules_tinygo//:toolchain_type",
)
