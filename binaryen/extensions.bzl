"""
Extensions for bzlmod.
"""

load(":repositories.bzl", "binaryen_register_toolchains")

_DEFAULT_NAME = "binaryen"

binaryen_toolchain = tag_class(attrs = {
    "name": attr.string(
        default = _DEFAULT_NAME,
    ),
    "binaryen_version": attr.string(mandatory = True),
})

def _toolchain_extension(module_ctx):
    registrations = {}
    for mod in module_ctx.modules:
        for toolchain in mod.tags.toolchain:
            if toolchain.name != _DEFAULT_NAME and not mod.is_root:
                fail("""\
                Only the root module may override the default name for the tinygo toolchain.
                This prevents conflicting registrations in the global namespace of external repos.
                """)
            if toolchain.name not in registrations.keys():
                registrations[toolchain.name] = []
            registrations[toolchain.name].append(toolchain.binaryen_version)
    for name, versions in registrations.items():
        if len(versions) > 1:
            selected = sorted(versions, reverse = True)[0]

            # buildifier: disable=print
            print("NOTE: binaryen toolchain {} has multiple versions {}, selected {}".format(name, versions, selected))
        else:
            selected = versions[0]

        binaryen_register_toolchains(
            name = name,
            binaryen_version = selected,
            register = False,
        )

binaryen = module_extension(
    implementation = _toolchain_extension,
    tag_classes = {"toolchain": binaryen_toolchain},
)
