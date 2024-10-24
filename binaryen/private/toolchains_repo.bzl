"""Toolchain repo"""

PLATFORMS = {
    "arm64-macos": struct(
        compatible_with = [
            "@platforms//os:macos",
            "@platforms//cpu:aarch64",
        ],
    ),
    "x86_64-linux": struct(
        compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:x86_64",
        ],
    ),
    "aarch64-linux": struct(
        compatible_with = [
            "@platforms//os:linux",
            "@platforms//cpu:aarch64",
        ],
    ),
}

def _toolchains_repo_impl(repository_ctx):
    build_content = """# Generated by toolchains_repo.bzl

"""
    for [platform, meta] in PLATFORMS.items():
        build_content += """
toolchain(
    name = "{platform}_toolchain",
    exec_compatible_with = {compatible_with},
    toolchain = "@{user_repository_name}_{platform}//:binaryen_toolchain",
    toolchain_type = "@rules_tinygo//binaryen:toolchain_type",
)

""".format(
            platform = platform,
            user_repository_name = repository_ctx.attr.user_repository_name,
            compatible_with = meta.compatible_with,
        )

    repository_ctx.file("BUILD", build_content)

toolchains_repo = repository_rule(
    implementation = _toolchains_repo_impl,
    attrs = {
        "user_repository_name": attr.string(),
    },
)
