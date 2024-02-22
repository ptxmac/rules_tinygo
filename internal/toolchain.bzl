def _tinygo_toolchain_impl(ctx):
    tinygo_cmd = None

    for f in ctx.files.tools:
        if f.path.endswith("bin/tinygo"):
            tinygo_cmd = f
            break

    if not tinygo_cmd:
        fail("tinygo not found in tools")

    return [platform_common.ToolchainInfo(
        tinygo = tinygo_cmd,
        srcs = ctx.files.srcs,
        libs = ctx.files.libs,
    )]

tinygo_toolchain = rule(
    implementation = _tinygo_toolchain_impl,
    attrs = {
        "tools": attr.label_list(mandatory = True),
        "srcs": attr.label_list(mandatory = True),
        "libs": attr.label_list(mandatory = True),
    },
)
