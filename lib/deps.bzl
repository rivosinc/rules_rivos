# SPDX-FileCopyrightText: Copyright (c) 2022 by Rivos Inc.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
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
