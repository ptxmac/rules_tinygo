load("@bazel_skylib//lib:shell.bzl", "shell")
load("@io_bazel_rules_go//go:def.bzl", "GoSDK")
load("@bazel_skylib//lib:paths.bzl", "paths")

def _tinygo_binary(ctx):
    srcs = ctx.files.srcs

    output_path = "{name}_/{name}".format(name = ctx.label.name)
    output = ctx.actions.declare_file(output_path)
    print("hello from tinygo_binary", srcs, output)

    toolchain = ctx.toolchains["@rules_tinygo//:toolchain_type"]

    cmd = "{tinygo} build -o {out} {srcs}".format(
        tinygo = toolchain.tinygo.path,
        out = output.path,
        srcs = " ".join([shell.quote(src.path) for src in srcs]),
    )

    print(cmd)

    sdk = ctx.attr.go_sdk[GoSDK]

    # print("sdk", sdk)
    # print("r", sdk.go.tree_relative_path)

    print("tools", sdk.tools[0])

    ctx.actions.run(
        executable = ctx.executable._builder,
        inputs = srcs + [toolchain.tinygo] + toolchain.srcs + toolchain.libs + [sdk.go] + sdk.srcs + sdk.tools,
        arguments = [toolchain.tinygo.path, "build", "-x", "-o", output.path] + [src.path for src in srcs],
        outputs = [output],
        env = {
            "BUILDER_GOROOT": sdk.root_file.dirname,
            "HOME": "/tmp/tinygexp",
            "BUILDER_GOBIN_PATH": sdk.go.dirname,
            "BUILDER_TINYGOROOT": paths.dirname(paths.dirname(toolchain.tinygo.path)),
        },
    )

    #    ctx.actions.run_shell(
    #        mnemonic = "TinyGo",
    #        outputs = [output],
    #        inputs = srcs + [toolchain.tinygo] + [sdk.go],
    #        command = cmd,
    #        use_default_shell_env = True,
    #        env = {
    #            "GOROOT": sdk.root_file.dirname,
    #            "PATH": sdk.go.dirname,
    #        },
    #    )

    return [DefaultInfo(
        files = depset([output]),
        executable = output,
    )]

tinygo_binary = rule(
    implementation = _tinygo_binary,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".go"],
            doc = "Source files to compile.",
        ),
        "go_sdk": attr.label(
            doc = "Go SDK to use.",
        ),
        "_builder": attr.label(
            default = Label("@rules_tinygo//internal/builder:builder"),
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
    executable = True,
    toolchains = ["@rules_tinygo//:toolchain_type"],
)