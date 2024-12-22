"""Hello World repository rules."""

load("//binaryen/private:toolchains_repo.bzl", "PLATFORMS", "toolchains_repo")
load("//binaryen/private:versions.bzl", "TOOL_VERSIONS")

def _binaryen_repo_impl(repository_ctx):
    url = "https://github.com/WebAssembly/binaryen/releases/download/version_{0}/binaryen-version_{0}-{1}.tar.gz".format(
        repository_ctx.attr.binaryen_version,
        repository_ctx.attr.platform,
    )
    repository_ctx.download_and_extract(
        url = url,
        stripPrefix = "binaryen-version_{0}".format(repository_ctx.attr.binaryen_version),
        integrity = TOOL_VERSIONS[repository_ctx.attr.binaryen_version][repository_ctx.attr.platform],
    )
    build_content = """
load("@rules_tinygo//binaryen:toolchain.bzl", "binaryen_toolchain")

filegroup(
    name = "tools",
    srcs = glob(["bin/*"]),
)

binaryen_toolchain(
    name = "binaryen_toolchain",
    tools = [":tools"],
)
"""
    repository_ctx.file("BUILD.bazel", build_content)

binaryen_repositories = repository_rule(
    implementation = _binaryen_repo_impl,
    attrs = {
        "binaryen_version": attr.string(mandatory = True, values = TOOL_VERSIONS.keys()),
        "platform": attr.string(mandatory = True, values = PLATFORMS.keys()),
    },
)

def binaryen_register_toolchains(name, register = True, **kwargs):
    """
    Register binaryen toolchains for all platforms.

    Args:
      name: The base name of the repos.
      register: Whether to register the toolchains using native.register_toolchains.
        Should be true only for WORKSPACE usage.
      **kwargs: Additional arguments to pass to binaryen_repositories.
    """
    for platform in PLATFORMS:
        binaryen_repositories(
            name = name + "_" + platform,
            platform = platform,
            **kwargs
        )
        if register:
            native.register_toolchains("@%s_toolchains//:%s_toolchain" % (name, platform))

    toolchains_repo(
        name = name + "_toolchains",
        user_repository_name = name,
    )
