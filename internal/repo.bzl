def _tinygo_download_impl(ctx):
    ctx.report_progress("downloading")
    ctx.download_and_extract(
        ctx.attr.urls,
        sha256 = ctx.attr.sha256,
        stripPrefix = "tinygo",
        canonical_id = " ".join(ctx.attr.urls),
    )

    ctx.template(
        "BUILD.bazel",
        ctx.attr._build_tpl,
    )

tinygo_download = repository_rule(
    implementation = _tinygo_download_impl,
    attrs = {
        "urls": attr.string_list(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "_build_tpl": attr.label(
            default = "@rules_tinygo//internal:BUILD.dist.bazel.tpl",
        ),
    },
)
