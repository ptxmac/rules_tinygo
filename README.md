<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# Tinygo rules for Bazel

> [!caution]
> EXPERIMENTAL

This package provides rules for building Go code with
 [TinyGo](https://tinygo.org/).

## Dependencies

Make sure [rules_go](https://github.com/bazelbuild/rules_go) is configured in your project.

## Setup

In `WORKSPACE`:

Start by loading the rules:

```bazel
git_repository(
    name = "rules_tinygo",
    commit = "0677286b5a5ceeb077044019152f5e72b23c37c9",
    remote = "git@github.com:ptxmac/rules_tinygo.git",
)
```

To use the TinyGo rules, both the tinygo and binaryen tools must be downloaded for the host architecture.


```bazel
TINYGO_VERSION = "0.31.2"
BINARYEN_VERSION = "117"

tinygo_download(
    name = "tinygo_darwin_arm64",
    sha256 = "5b9ff15881bd23eb44ccd0e6c917db11e65c5532d654fc7198e6f6289aa0449d",
    urls = ["https://github.com/tinygo-org/tinygo/releases/download/v{0}/tinygo{0}.darwin-arm64.tar.gz".format(TINYGO_VERSION)],
)

binaryen_download(
    name = "binaryen_darwin_arm64",
    prefix = "binaryen-version_{0}".format(BINARYEN_VERSION),
    sha256 = "f2d962ff294b38ea3cfbbae8f6c728089d9375a57bac9a1880eb86779d6d3a84",
    urls = ["https://github.com/WebAssembly/binaryen/releases/download/version_{0}/binaryen-version_{0}-arm64-macos.tar.gz".format(BINARYEN_VERSION)],
)
```

Then all toolchains must be registered:

```bazel
register_toolchains(
    "@tinygo_darwin_arm64//:toolchain_darwin_arm64",
    "@binaryen_darwin_arm64//:binaryen_darwin_arm64",
)
```

## Usage

load("@rules_tinygo//:def.bzl", "tinygo_binary")

tinygo_binary(
    name = "hello_wasi",
    srcs = ["hello.go"],
    out = "hello.wasi",
    target = "wasi",
)

# Rules

<a id="tinygo_binary"></a>

## tinygo_binary

<pre>
tinygo_binary(<a href="#tinygo_binary-name">name</a>, <a href="#tinygo_binary-srcs">srcs</a>, <a href="#tinygo_binary-out">out</a>, <a href="#tinygo_binary-go_sdk">go_sdk</a>, <a href="#tinygo_binary-target">target</a>)
</pre>

Compiles a Go binary using TinyGo.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="tinygo_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="tinygo_binary-srcs"></a>srcs |  Source files to compile.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="tinygo_binary-out"></a>out |  Output binary.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="tinygo_binary-go_sdk"></a>go_sdk |  Go SDK to use.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `"@go_sdk"`  |
| <a id="tinygo_binary-target"></a>target |  Target architecture.   | String | optional |  `""`  |


<a id="binaryen_download"></a>

## binaryen_download

<pre>
binaryen_download(<a href="#binaryen_download-name">name</a>, <a href="#binaryen_download-prefix">prefix</a>, <a href="#binaryen_download-repo_mapping">repo_mapping</a>, <a href="#binaryen_download-sha256">sha256</a>, <a href="#binaryen_download-urls">urls</a>)
</pre>

Downloads and extracts the Binaryen tools.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="binaryen_download-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="binaryen_download-prefix"></a>prefix |  -   | String | optional |  `""`  |
| <a id="binaryen_download-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |
| <a id="binaryen_download-sha256"></a>sha256 |  -   | String | required |  |
| <a id="binaryen_download-urls"></a>urls |  -   | List of strings | required |  |


<a id="tinygo_download"></a>

## tinygo_download

<pre>
tinygo_download(<a href="#tinygo_download-name">name</a>, <a href="#tinygo_download-repo_mapping">repo_mapping</a>, <a href="#tinygo_download-sha256">sha256</a>, <a href="#tinygo_download-urls">urls</a>)
</pre>

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="tinygo_download-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="tinygo_download-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |
| <a id="tinygo_download-sha256"></a>sha256 |  -   | String | required |  |
| <a id="tinygo_download-urls"></a>urls |  -   | List of strings | required |  |


