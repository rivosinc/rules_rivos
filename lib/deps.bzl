# SPDX-FileCopyrightText: 2022 Rivos Inc.
#
# SPDX-License-Identifier: Apache-2.0

load("@rules_cc//cc:repositories.bzl",
     "rules_cc_dependencies",
     "rules_cc_toolchains")

load("@rules_pkg//pkg:deps.bzl",
     "rules_pkg_dependencies")

load("@rules_foreign_cc//foreign_cc:repositories.bzl",
     "rules_foreign_cc_dependencies")

def rivos_dependencies():
    rules_cc_dependencies()
    rules_cc_toolchains()
    rules_pkg_dependencies()
    rules_foreign_cc_dependencies()
