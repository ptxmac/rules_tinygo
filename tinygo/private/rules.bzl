"""
The rules for TinyGo.
"""

load("@bazel_skylib//lib:paths.bzl", "paths")
load("@rules_go//go:def.bzl", "GoInfo", "GoPath", "GoSDK")

def _tinygo_binary(ctx):
    srcs = ctx.files.srcs
    embed = ctx.attr.embed
    importpath = ctx.attr.importpath
    gopath = ctx.attr.gopath

    if embed:
        if importpath:
            fail("tinygo_binary: set embed or importpath, not both")
        if not ctx.file.mod:
            fail("tinygo_binary: mod is required when embed is set")
        if not gopath:
            fail("tinygo_binary: internal error: gopath is required when embed is set")
        importpath = embed[0][GoInfo].importpath
        if not importpath:
            fail("tinygo_binary: embed target must have an importpath")
    elif not importpath and not srcs:
        fail("tinygo_binary: embed, importpath, or srcs is required")

    if importpath and not embed and not ctx.file.mod:
        fail("tinygo_binary: mod is required when importpath is set")
    if srcs and importpath and not ctx.attr.package_dir and not embed:
        fail("tinygo_binary: package_dir is required when both importpath and srcs are set")

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

    if ctx.attr.scheduler:
        args += ["-scheduler", ctx.attr.scheduler]

    if ctx.attr.buildmode:
        args += ["-buildmode", ctx.attr.buildmode]

    sdk = ctx.attr.go_sdk[GoSDK]
    mod_inputs = []
    extra_inputs = []
    env = {
        "BUILDER_GOROOT": sdk.root_file.dirname,
        "HOME": "/tmp/tinygexp",
        "BUILDER_GOBIN_PATH": sdk.go.dirname,
        "BUILDER_TINYGOROOT": paths.dirname(paths.dirname(toolchain.tinygo)),
        "WASMOPT": binaryen.wasm_opt.path,
    }
    execution_requirements = {}

    if importpath:
        mod = ctx.file.mod
        mod_inputs = [mod]
        if ctx.file.sum:
            mod_inputs.append(ctx.file.sum)
        mod_dir = paths.dirname(mod.path)
        if mod_dir == "":
            mod_dir = "."
        env["BUILDER_GOMOD_DIR"] = mod_dir
        args.append(importpath)
        execution_requirements["requires-network"] = "1"
        if gopath:
            gopath_info = gopath[GoPath]
            env["BUILDER_GOPATH_DIR"] = gopath_info.gopath_file.path
            extra_inputs = gopath[DefaultInfo].files.to_list()
        elif srcs:
            env["BUILDER_COPY_SPECS"] = ",".join([
                ctx.attr.package_dir + "/" + paths.basename(src.path) + "|" + src.path
                for src in srcs
            ])
    else:
        args += [src.path for src in srcs]

    ctx.actions.run(
        executable = ctx.executable._builder,
        inputs = depset(
            direct = (
                toolchain.tool_files +
                srcs +
                mod_inputs +
                toolchain.srcs +
                toolchain.libs +
                toolchain.targets +
                [sdk.go, binaryen.wasm_opt] +
                extra_inputs
            ),
            transitive = [
                sdk.srcs,
                sdk.tools,
            ],
        ),
        arguments = args,
        outputs = [ctx.outputs.out],
        env = env,
        execution_requirements = execution_requirements,
    )

    return [DefaultInfo(
        files = depset([ctx.outputs.out]),
    )]

tinygo_binary = rule(
    implementation = _tinygo_binary,
    doc = "Compiles a Go binary using TinyGo.",
    attrs = {
        "embed": attr.label_list(
            providers = [GoInfo],
            doc = "go_library targets to embed, like go_binary. Requires mod and a gopath target.",
        ),
        "gopath": attr.label(
            providers = [GoPath],
            doc = "Internal go_path output populated by the tinygo_binary macro.",
        ),
        "srcs": attr.label_list(
            allow_files = [".go"],
            doc = "Source files to compile. With importpath, main-package sources copied into package_dir.",
        ),
        "importpath": attr.string(
            doc = "Import path of the main package to build in module mode. Requires mod.",
        ),
        "package_dir": attr.string(
            doc = "Module-relative directory for srcs when building importpath with local sources.",
        ),
        "mod": attr.label(
            allow_single_file = [".mod"],
            doc = "go.mod file for module-mode builds.",
        ),
        "sum": attr.label(
            allow_single_file = [".sum"],
            doc = "go.sum file for module-mode builds.",
        ),
        "scheduler": attr.string(
            doc = "Optional TinyGo scheduler, e.g. \"none\".",
        ),
        "buildmode": attr.string(
            doc = "Optional TinyGo build mode, e.g. \"wasi-legacy\" for Zellij plugins.",
        ),
        "target": attr.string(
            doc = "Target architecture.",
        ),
        "out": attr.output(
            doc = "Output binary.",
        ),
        "go_sdk": attr.label(
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
