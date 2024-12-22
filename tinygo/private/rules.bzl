"""
The rules for TinyGo.
"""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_go//go:def.bzl", "GoSDK")

def _tinygo_binary(ctx):
    srcs = ctx.files.srcs

    binaryen = ctx.toolchains["@rules_tinygo//binaryen:toolchain_type"]
    toolchain = ctx.toolchains["@rules_tinygo//tinygo:toolchain_type"]

    args = [
        toolchain.tinygo,
        "build",
        "-x",
        "-o",
        ctx.outputs.out.path,
    ]

    if ctx.attr.target:
        args += ["-target", ctx.attr.target]

    args += [src.path for src in srcs]
    sdk = ctx.attr.go_sdk[GoSDK]

    ctx.actions.run(
        executable = ctx.executable._builder,
        inputs = (
            toolchain.tool_files +
            srcs +
            toolchain.srcs +
            toolchain.libs +
            toolchain.targets +
            [sdk.go] +
            sdk.srcs.to_list() +
            sdk.tools.to_list() +
            [binaryen.wasm_opt]
        ),
        arguments = args,
        outputs = [ctx.outputs.out],
        env = {
            "BUILDER_GOROOT": sdk.root_file.dirname,
            "HOME": "/tmp/tinygexp",
            "BUILDER_GOBIN_PATH": sdk.go.dirname,
            "BUILDER_TINYGOROOT": paths.dirname(paths.dirname(toolchain.tinygo)),
            "WASMOPT": binaryen.wasm_opt.path,
        },
    )

    return [DefaultInfo(
        files = depset([ctx.outputs.out]),
    )]

tinygo_binary = rule(
    implementation = _tinygo_binary,
    doc = "Compiles a Go binary using TinyGo.",
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".go"],
            doc = "Source files to compile.",
        ),
        "target": attr.string(
            doc = "Target architecture.",
        ),
        "out": attr.output(
            doc = "Output binary.",
        ),
        "go_sdk": attr.label(
            # mandatory = True,
            doc = "Go SDK to use.",
            providers = [GoSDK],
            default = Label("@go_default_sdk//:go_sdk"),
        ),
        "_builder": attr.label(
            default = Label("@rules_tinygo//tinygo/builder:builder"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
    toolchains = [
        "@rules_tinygo//tinygo:toolchain_type",
        "@rules_tinygo//binaryen:toolchain_type",
    ],
)
