"""This module implements the language-specific toolchain rule."""

# Avoid using non-normalized paths (workspace/../other_workspace/path)
def _to_manifest_path(ctx, file):
    if file.short_path.startswith("../"):
        return "external/" + file.short_path[3:]
    else:
        return ctx.workspace_name + "/" + file.short_path

def _tinygo_toolchain_impl(ctx):
    tool_files = []
    tinygo_cmd = None

    for f in ctx.files.tools:
        if f.path.endswith("bin/tinygo"):
            tool_files.append(f)
            tinygo_cmd = _to_manifest_path(ctx, f)
            break
    if not tinygo_cmd:
        fail("tinygo not found in tools")

    return [platform_common.ToolchainInfo(
        tool_files = tool_files,
        tinygo = tinygo_cmd,
        srcs = ctx.files.srcs,
        targets = ctx.files.targets,
        libs = ctx.files.libs,
    )]

tinygo_toolchain = rule(
    implementation = _tinygo_toolchain_impl,
    attrs = {
        "tools": attr.label_list(mandatory = True),
        "srcs": attr.label_list(mandatory = True),
        "targets": attr.label_list(mandatory = True),
        "libs": attr.label_list(mandatory = True),
    },
    doc = """Defines a tinygo compiler/runtime toolchain.

For usage see https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains.
""",
)
