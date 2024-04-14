def _binaryen_download_impl(ctx):
    ctx.report_progress("downloadsing")
    ctx.download_and_extract(
        ctx.attr.urls,
        sha256 = ctx.attr.sha256,
        stripPrefix = ctx.attr.prefix,
        canonical_id = " ".join(ctx.attr.urls),
    )
    ctx.template(
        "BUILD.bazel",
        ctx.attr._build_tpl,
    )

binaryen_download = repository_rule(
    implementation = _binaryen_download_impl,
    attrs = {
        "urls": attr.string_list(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "prefix": attr.string(default = ""),
        "_build_tpl": attr.label(default = Label("//binaryen:BUILD.dist.bazel.tpl")),
    },
)
