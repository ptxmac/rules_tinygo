#!/usr/bin/env bash
bazel build //docs:docs
cp bazel-bin/docs/README.md README.md
