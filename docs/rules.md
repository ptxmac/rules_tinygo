<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="tinygo_binary"></a>

## tinygo_binary

<pre>
load("@rules_tinygo//tinygo:defs.bzl", "tinygo_binary")

tinygo_binary(<a href="#tinygo_binary-name">name</a>, <a href="#tinygo_binary-embed">embed</a>, <a href="#tinygo_binary-mod">mod</a>, <a href="#tinygo_binary-sum">sum</a>, <a href="#tinygo_binary-kwargs">**kwargs</a>)
</pre>

Builds a TinyGo binary.

When `embed` is set (like `go_binary`), a hidden `go_path` target materializes
the embedded library and its transitive dependencies for module-mode TinyGo.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="tinygo_binary-name"></a>name |  Target name.   |  none |
| <a id="tinygo_binary-embed"></a>embed |  go_library targets to embed, like go_binary.   |  `None` |
| <a id="tinygo_binary-mod"></a>mod |  Module root go.mod label; required when embed is set.   |  `None` |
| <a id="tinygo_binary-sum"></a>sum |  Optional go.sum label for the module root.   |  `None` |
| <a id="tinygo_binary-kwargs"></a>kwargs |  Remaining attributes passed to the underlying tinygo_binary rule.   |  none |


