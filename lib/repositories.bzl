# SPDX-FileCopyrightText: Copyright (c) 2022 by Rivos Inc.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

load("@bazel_tools//tools/build_defs/repo:http.bzl",
     "http_archive")

load("@bazel_tools//tools/build_defs/repo:git.bzl",
     "git_repository")

def maybe_http_archive(name, **kwargs):
    if not native.existing_rule(name):
        http_archive(name = name, **kwargs)

def maybe_git_repository(name, **kwargs):
    if not native.existing_rule(name):
        git_repository(name = name, **kwargs)

def rivos_repositories():
    """ Bazel repos first """
    maybe_http_archive(
        name = "platforms",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/platforms/releases/download/0.0.6/platforms-0.0.6.tar.gz",
            "https://github.com/bazelbuild/platforms/releases/download/0.0.6/platforms-0.0.6.tar.gz",
        ],
        sha256 = "5308fc1d8865406a49427ba24a9ab53087f17f5266a7aabbfc28823f3916e1ca",
    )
    maybe_http_archive(
        name = "bazel_skylib",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.3.0/bazel-skylib-1.3.0.tar.gz",
        ],
        sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    )
    maybe_http_archive(
        name = "rules_cc",
        urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.4/rules_cc-0.0.4.tar.gz"],
        sha256 = "af6cc82d87db94585bceeda2561cb8a9d55ad435318ccb4ddfee18a43580fb5d",
        strip_prefix = "rules_cc-0.0.4",
    )
    maybe_http_archive(
        name = "rules_rust",
        urls = ["https://github.com/bazelbuild/rules_rust/releases/download/0.17.0/rules_rust-v0.17.0.tar.gz"],
        sha256 = "d125fb75432dc3b20e9b5a19347b45ec607fabe75f98c6c4ba9badaab9c193ce",
    )
    maybe_http_archive(
        name = "rules_foreign_cc",
        urls = ["https://github.com/bazelbuild/rules_foreign_cc/archive/0.9.0.tar.gz"],
        sha256 = "2a4d07cd64b0719b39a7c12218a3e507672b82a97b98c6a89d38565894cf7c51",
        strip_prefix = "rules_foreign_cc-0.9.0",
    )
    maybe_http_archive(
        name = "rules_pkg",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.8.0/rules_pkg-0.8.0.tar.gz",
            "https://github.com/bazelbuild/rules_pkg/releases/download/0.8.0/rules_pkg-0.8.0.tar.gz",
        ],
        sha256 = "eea0f59c28a9241156a47d7a8e32db9122f3d50b505fae0f33de6ce4d9b61834",
    )
    """ Platforms toolchains """
    maybe_http_archive(
        name = "riscv32_elf_toolchain",
        urls = [
            "https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2022.08.26/riscv32-elf-ubuntu-20.04-nightly-2022.08.26-nightly.tar.gz",
        ],
        sha256 = "6569bf096e7b08cffbbd6e881ef8e6063d9d5e99b354a956ba2f805a23a79089",
        build_file = "@rules_rivos//toolchains:BUILD.riscv32_elf_toolchain.bazel",
    )
    maybe_http_archive(
        name = "riscv32_gnu_toolchain",
        urls = [
            "https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2022.08.26/riscv32-glibc-ubuntu-20.04-nightly-2022.08.26-nightly.tar.gz",
        ],
        sha256 = "16864a6934f6e7e4e98e108e1c6c1e1177fbe6edaf1874ec412369073051dee4",
        build_file = "@rules_rivos//toolchains:BUILD.riscv32_gnu_toolchain.bazel",
    )
    maybe_http_archive(
        name = "riscv64_elf_toolchain",
        urls = [
            "https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2022.08.26/riscv64-elf-ubuntu-20.04-nightly-2022.08.26-nightly.tar.gz",
        ],
        sha256 = "c7aeedededbd5c4c29d70f9b660a2101264f0b6bc1e7732ba687e4e1125ba6a9",
        build_file = "@rules_rivos//toolchains:BUILD.riscv64_elf_toolchain.bazel",
    )
    maybe_http_archive(
        name = "riscv64_gnu_toolchain",
        urls = [
            "https://github.com/riscv-collab/riscv-gnu-toolchain/releases/download/2022.08.26/riscv64-glibc-ubuntu-20.04-nightly-2022.08.26-nightly.tar.gz",
        ],
        sha256 = "601006ef4d7a9f96bfc854ac247325be50e696d20e52a9899b48a556416732df",
        build_file = "@rules_rivos//toolchains:BUILD.riscv64_gnu_toolchain.bazel",
    )
