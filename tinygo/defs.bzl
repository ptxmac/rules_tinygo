"Public API re-exports"

load("@rules_go//go:def.bzl", "go_path")
load("//tinygo/private:rules.bzl", _tinygo_binary = "tinygo_binary")

def tinygo_binary(name, embed = None, mod = None, sum = None, **kwargs):
    """Builds a TinyGo binary.

    When `embed` is set, a hidden `go_path` target materializes the embedded
    libraries and their transitive dependencies. TinyGo builds from that tree in
    GOPATH mode without `go.mod` or network access.

    Args:
      name: Target name.
      embed: go_library targets to embed, like go_binary.
      mod: go.mod label for module-mode importpath builds. Ignored when embed is set.
      sum: Optional go.sum label for module-mode importpath builds. Ignored when embed is set.
      **kwargs: Remaining attributes passed to the underlying tinygo_binary rule.
    """
    if embed:
        gopath_name = name + "_gopath"
        go_path(
            name = gopath_name,
            deps = embed,
            mode = "copy",
            visibility = ["//visibility:private"],
        )
        _tinygo_binary(
            name = name,
            embed = embed,
            gopath = ":" + gopath_name,
            **kwargs
        )
    else:
        _tinygo_binary(
            name = name,
            mod = mod,
            sum = sum,
            **kwargs
        )
