def _binary_toolchain_impl(ctx):
    # find wasm-opt
    wasm_opt = None
    for f in ctx.files.tools:
        if f.path.endswith("wasm-opt"):
            wasm_opt = f
            break
    if not wasm_opt:
        fail("wasm-opt not found in tools")

    return [platform_common.ToolchainInfo(
        wasm_opt = wasm_opt,
    )]

binaryen_toolchain = rule(
    implementation = _binary_toolchain_impl,
    attrs = {
        "tools": attr.label_list(allow_files = True),
    },
)
