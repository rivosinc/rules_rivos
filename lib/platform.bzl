# SPDX-FileCopyrightText: 2022 - 2023 Rivos Inc.
#
# SPDX-License-Identifier: Apache-2.0

"""Platform Transitions Support"""

def _platform_transition_impl(settings, attr):
    """The implementation of the `platform_transition` transition.
    This transition modifies the config to use specified target platform for the
    target and all their dependencies.
    Args:
        settings (dict): a dict {String:Object} of all settings declared in the
            inputs parameter to `transition()`.
        attr (dict): A dict of attributes and values of the rule to which the
            transition is attached, in particular the target `platform` name.
    Returns:
        dict: A dict of new build settings values to apply.
    """
    _ignore = (settings)
    return { "//command_line_option:platforms": attr.platform }

platform_transition = transition(
    implementation = _platform_transition_impl,
    inputs = [],
    outputs = ["//command_line_option:platforms"],
)

def _platform_binary_impl(ctx):
    executable = ctx.actions.declare_file(
        ctx.label.name,
    )

    ctx.actions.symlink(
        output = executable,
        target_file = ctx.executable.executable,
        is_executable = True,
    )

    runfiles = ctx.runfiles(files = [executable, ctx.executable.executable] + ctx.files.data)
    runfiles = runfiles.merge(ctx.attr.executable[DefaultInfo].default_runfiles)
    for data_dep in ctx.attr.data:
        runfiles = runfiles.merge(data_dep[DefaultInfo].default_runfiles)

    return [DefaultInfo(
        executable = executable,
        files = depset(direct = [executable]),
        runfiles = runfiles,
    )]

platform_binary = rule(
    implementation = _platform_binary_impl,
    doc = "Alias-like rule to build the `executable` using target `platform` configuration.",
    attrs = {
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
        "data": attr.label_list(allow_files = True),
        "platform": attr.string(),
        "executable": attr.label(
            cfg = "target",
            executable = True,
        ),
    },
    cfg = platform_transition,
    executable = True,
)

def _platform_file_impl(ctx):
    executable = ctx.actions.declare_file(
        ctx.label.name,
    )

    match = ctx.label.name
    if ctx.attr.executable:
        match = ctx.attr.executable

    target_file = [ f for f in ctx.files.srcs if f.basename == match ]
    if len(target_file) != 1:
        fail("Can't find matching file: {}".format(ctx.label.name))

    ctx.actions.symlink(
        output = executable,
        target_file = target_file[0],
        is_executable = True,
    )

    runfiles = ctx.runfiles(files = ctx.files.data)
    for data_dep in ctx.attr.data:
        runfiles = runfiles.merge(data_dep[DefaultInfo].default_runfiles)

    return [DefaultInfo(
        executable = executable,
        files = depset(direct = [executable]),
        runfiles = runfiles,
    )]

platform_file = rule(
    implementation = _platform_file_impl,
    doc = "Alias-like rule to build all the `srcs` using target `platform` configuration.",
    attrs = {
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
        "srcs": attr.label_list(allow_files = True),
        "data": attr.label_list(allow_files = True),
        "executable": attr.string(),
        "platform": attr.string(),
    },
    cfg = platform_transition,
    executable = True,
)
