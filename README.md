<!-- Generated with Stardoc: http://skydoc.bazel.build -->

# Tinygo rules for Bazel

> [!caution]
> EXPERIMENTAL

This package provides rules for building Go code with [TinyGo](https://tinygo.org/).

<a id="tinygo_binary"></a>

## tinygo_binary

<pre>
tinygo_binary(<a href="#tinygo_binary-name">name</a>, <a href="#tinygo_binary-srcs">srcs</a>, <a href="#tinygo_binary-out">out</a>, <a href="#tinygo_binary-go_sdk">go_sdk</a>, <a href="#tinygo_binary-target">target</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="tinygo_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="tinygo_binary-srcs"></a>srcs |  Source files to compile.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="tinygo_binary-out"></a>out |  Output binary.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="tinygo_binary-go_sdk"></a>go_sdk |  Go SDK to use.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="tinygo_binary-target"></a>target |  Target architecture.   | String | optional |  `""`  |


