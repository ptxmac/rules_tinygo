"""Provides a simple way to test your rules as an external workspace.
Add a basic smoke-test target below.
"""

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@rules_go//go:def.bzl", "go_test")
load("@rules_tinygo//tinygo:defs.bzl", "tinygo_binary")

# Replace with a usage of your rule/macro
filegroup(name = "empty")

build_test(
    name = "smoke_test",
    targets = [
        # targets you add above
        ":empty",
    ],
)

tinygo_binary(
    name = "hello_wasi",
    srcs = ["hello.go"],
    out = "hello.wasi",
    target = "wasi",
)

go_test(
    name = "hello_test",
    srcs = ["hello_test.go"],
    data = [":hello_wasi"],
)
